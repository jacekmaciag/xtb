# frozen_string_literal: true

require 'openssl'
require 'connection_pool'

require_relative '../error'
require_relative '../configuration'
require_relative '../request_queue'

module Xtb
  module Http
    # Client for XTB API.
    class Client
      include RequestQueue

      attr_accessor :stream_session_id

      def initialize
        @ssl_socket = new_ssl_socket
      end

      # Sends a request to the broker server utilizing a connection pool to manage connections.
      def self.post
        connection_pool.with do |connection|
          with_request_queue do
            yield connection
          end
        end
      end

      def self.connection_pool
        @connection_pool ||= ConnectionPool.new(size: Xtb.connection_pool_size, timeout: 30) do
          connection = new
          login = Xtb::Http::Login.call(connection:)
          connection.stream_session_id = login.stream_session_id

          connection
        end
      end
      private_class_method :connection_pool

      def request(payload)
        ssl_socket.puts(payload)
        response
      end

      private

      attr_reader :ssl_socket

      def response
        buffer = []

        while (line = ssl_socket.gets)
          break if line.strip.empty?

          buffer << line
        end

        buffer.join.strip
      end

      def new_ssl_socket
        OpenSSL::SSL::SSLSocket.open(Xtb.https.host, Xtb.https.port).tap do |socket|
          socket.hostname = Xtb.https.host
          socket.sync_close = true
        end.connect
      end
    end
  end
end
