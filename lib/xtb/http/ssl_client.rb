# frozen_string_literal: true

require 'openssl'
require_relative '../config'

module Xtb
  module Http
    class SslClient
      class << self
        def request(payload)
          ssl_socket.connect
          ssl_socket.puts(payload)
          next_line
        end

        private

        def next_line
          line = ssl_socket.gets.chomp
          return line unless line.empty?

          next_line
        end

        def ssl_context
          @ssl_context ||= OpenSSL::SSL::SSLContext.new
        end

        def ssl_socket
          @ssl_socket ||= OpenSSL::SSL::SSLSocket.new(tcp_socket, ssl_context) do |socket|
            socket.hostname = Config.https_host
            socket.sync_close = true
            socket
          end
        end

        def tcp_socket
          TCPSocket.new(Config.https_host, Config.https_port)
        end
      end
    end
  end
end
