# frozen_string_literal: true

module Xtb
  # Configuration mapping for XTB API.
  class Config
    DEFAULT_HTTP_HOST = 'xapi.xtb.com'
    DEFAULT_HTTP_PORT = 5124
    DEFAULT_WEB_SOCKET_HOST = 'ws.xtb.com'
    DEFAULT_WEB_SOCKET_PORT = 5125
    DEFAULT_WEB_SOCKET_PATH = 'demo'
    DEFAULT_MIN_REQUEST_INTERVAL = 0.2

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

      def min_request_interval
        ENV.fetch('XTB__MIN_REQUEST_INTERVAL', DEFAULT_MIN_REQUEST_INTERVAL).to_f
      end
    end
  end
end
