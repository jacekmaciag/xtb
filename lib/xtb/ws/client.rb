# frozen_string_literal: true

require 'faye/websocket'
require 'eventmachine'
require 'uri'

require_relative '../configuration'
require_relative '../http/client'

module Xtb
  module Ws
    # Client for WebSocket connection.
    class Client
      EVENT_RECORD_OBJECTS = {
        getBalance: 'Xtb::Ws::Balance::StreamingBalanceRecord',
        getCandles: 'Xtb::Ws::Candles::StreamingCandleRecord',
        getTickPrices: 'Xtb::Ws::TickPrices::StreamingTickPricesRecord'
      }.freeze

      Response = Struct.new(:command, :raw_response) do
        def initialize(**args)
          super

          @response = parse
        end

        def status
          response[:status]
        end

        alias_method :success?, :status

        def return_data
          response[:return_data]
        end

        def stream_session_id
          response[:stream_session_id]
        end

        def error_code
          response[:error_code]
        end

        def error_description
          response[:error_descr]
        end

        private

        attr_reader :response

        def parse
          transform_keys(raw_response)
        end

        def transform_keys(hash)
          hash.transform_keys! do |key|
            key.underscore.to_sym
          end

          hash.transform_values do |value|
            transform_keys(value) if value.is_a?(Hash)
            value.each { |item| transform_keys(item) } if value.is_a?(Array)
            value
          end
        end
      end

      def initialize(arguments)
        @arguments = arguments
      end

      def self.post(arguments)
        new(arguments).post
      end

      def post
        Xtb::Http::Client.post do |connection|
          arguments.merge!({ streamSessionId: connection.stream_session_id })
          ws_socket(connection)
        end
      end

      def self.unsubscribe(command, arguments: {})
        arguments.merge!({ command: })
        ws_socket(connection)
      end

      private

      attr_reader :arguments

      def ws_socket(connection)
        EM.run do
          ws = Faye::WebSocket::Client.new(streaming_url)

          ws.on :open do |_event|
            ws.send(arguments.to_json)
          end

          ws.on :message do |event|
            event_data = JSON.parse(event.data)
            pp event_data
            response = Response.new(command: arguments[:command], raw_response: event_data)
            raise ErrorFactory.create(response.error_code, response.error_description) unless response.success?

            pp event_data
            event_record_object = EVENT_RECORD_OBJECTS[arguments[:command]].constantize.new(event_data['data'])
            # message_handler.call(event_record_object)
            pp event_record_object
          end

          ws.on :close do |event|
            reason = event.reason.empty? ? '<no reason>' : event.reason
            pp "XTB Websocket connection closed: #{event.code} - #{reason}"
            EM.stop
          end

          ws.ping({ command: :ping, streamSessionId: connection.stream_session_id }.to_json) do |data|
            pp "Ping: #{data}"
          end
        end
      end

      def streaming_url
        URI::WSS.build(host: settings.host, port: settings.port, path: settings.path).to_s
      end

      def settings
        Xtb.wss
      end

      def message_handler
        settings.message_handler
      end
    end
  end
end
