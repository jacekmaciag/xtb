# frozen_string_literal: true

module Xtb
  # Configuration mapping for XTB API.
  class Config
    class << self
      def https_host
        ENV.fetch('XTB__HTTPS_HOST', 'xapi.xtb.com')
      end

      def https_port
        ENV.fetch('XTB__HTTPS_PORT', 5124).to_i
      end

      def wss_host
        ENV.fetch('XTB__WSS_HOST', 'ws.xtb.com')
      end

      def wss_path
        ENV.fetch('XTB__WSS_PATH', 'demo')
      end

      def wss_port
        ENV.fetch('XTB__WSS_PORT', 5125).to_i
      end

      def user_id
        ENV.fetch('XTB__USER_ID') { raise 'XTB__USER_ID is required' }
      end

      def password
        ENV.fetch('XTB__PASSWORD') { raise 'XTB__PASSWORD is required' }
      end

      def min_request_interval
        ENV.fetch('XTB__MIN_REQUEST_INTERVAL', 0.2).to_f
      end
    end
  end
end
