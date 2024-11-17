# frozen_string_literal: true

require 'connection_pool'

require_relative '../error'
require_relative '../config'
require_relative '../request_queue'

module Xtb
  module Http
    # Client for XTB API.
    class Client
      include RequestQueue

      def initialize
        @ssl_socket = new_ssl_socket
      end

      # Sends a request to the broker server. It utilizes a connection pool to manage connections.
      def self.post
        connection_pool.with do |connection|
          with_request_queue do
            yield connection
          end
        end
      end

      def request(payload)
        ssl_socket.puts(payload)
        response
      end

      def stream_session_id
        @stream_session_id ||= BrokerClients::Xtb::Login.call.stream_session_id
      end

      private

      attr_reader :ssl_socket

      def self.connection_pool
        @connection_pool ||= ConnectionPool.new(size: Config.connection_pool_size, timeout: 30) do
          connection = new
          Xtb::Http::Login.call(connection:)

          connection
        end
      end

      def response
        buffer = []

        while (line = ssl_socket.gets)
          break if line.strip.empty?

          buffer << line
        end

        buffer.join.strip
      end

      def new_ssl_socket
        OpenSSL::SSL::SSLSocket.open(Config.https_host, Config.https_port).tap do |socket|
          socket.hostname = Config.https_host
          socket.sync_close = true
        end.connect
      end
    end
  end
end
