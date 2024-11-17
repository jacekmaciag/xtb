# frozen_string_literal: true

module Xtb
  # Configuration mapping for XTB API.
  class Config
    DEFAULT_HTTP_HOST = 'xapi.xtb.com'
    DEFAULT_HTTP_PORT = 5124
    DEFAULT_WEB_SOCKET_HOST = 'ws.xtb.com'
    DEFAULT_WEB_SOCKET_PORT = 5125
    DEFAULT_WEB_SOCKET_PATH = 'demo'
    DEFAULT_CONNECTION_POOL_SIZE = 5
    MAX_CONNECTION_POOL_SIZE = 50
    MIN_REQUEST_INTERVAL = 200 # in milliseconds

    class << self
      def https_host
        ENV.fetch('XTB__HTTPS_HOST', DEFAULT_HTTP_HOST)
      end

      def https_port
        ENV.fetch('XTB__HTTPS_PORT', DEFAULT_HTTP_PORT).to_i
      end

      def wss_host
        ENV.fetch('XTB__WSS_HOST', DEFAULT_WEB_SOCKET_HOST)
      end

      def wss_path
        ENV.fetch('XTB__WSS_PATH', DEFAULT_WEB_SOCKET_PATH)
      end

      def wss_port
        ENV.fetch('XTB__WSS_PORT', DEFAULT_WEB_SOCKET_PORT).to_i
      end

      def user_id
        ENV.fetch('XTB__USER_ID') { raise 'XTB__USER_ID is required' }
      end

      def password
        ENV.fetch('XTB__PASSWORD') { raise 'XTB__PASSWORD is required' }
      end

      def connection_pool_size
        size = ENV.fetch('XTB__CONNECTION_POOL_SIZE', DEFAULT_CONNECTION_POOL_SIZE).to_i
        raise "Max connection pool size is #{MAX_CONNECTION_POOL_SIZE}" if size > MAX_CONNECTION_POOL_SIZE

        size
      end

      def min_request_interval
        requests_interval = ENV.fetch('XTB__MIN_REQUEST_INTERVAL', MIN_REQUEST_INTERVAL).to_i
        if requests_interval < MIN_REQUEST_INTERVAL
          raise "Minimum request interval must be greater than or equal to #{MIN_REQUEST_INTERVAL}"
        end

        requests_interval
      end
    end
  end
end
