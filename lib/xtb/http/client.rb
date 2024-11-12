# frozen_string_literal: true

require_relative 'ssl_client'
require_relative '../error'
require_relative '../request_queue'

module Xtb
  module Http
    # Client for XTB API
    class Client
      include RequestQueue

      class << self
        def post(payload)
          with_request_queue do
            Xtb::Http::SslClient.request(payload)
          end
          # rescue NotLoggedInError => e
          #   return if command == :logout
          #
          #   Rails.logger.debug(e)
          #
          #   BrokerClients::Xtb::Login.call
          #   retry
          # rescue AlreadyLoggedInError => _e
          #   # noop
        end

        def stream_session_id
          @stream_session_id ||= BrokerClients::Xtb::Login.call.stream_session_id
        end

        private

        def ssl_client
          @ssl_client ||= Xtb::Http::SslClient.new
        end
      end
    end
  end
end
