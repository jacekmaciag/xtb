# frozen_string_literal: true

module Xtb
  module Http
    class Response
      def initialize(raw_response, command)
        @response = parse_json(raw_response)
        @command = command
      end

      def self.parse(raw_response, command)
        new(raw_response, command).parse
      end

      def parse
        return data if success?

        raise_error
      end

      private

      attr_reader :response, :command

      def parse_json(raw_response)
        JSON.parse(raw_response).deep_transform_keys { |key| key.underscore.to_sym }
      end

      def success?
        response[:status]
      end

      def data
        return response if command == :login

        response[:return_data]
      end

      def error_code
        response[:error_code]
      end

      def error_description
        response[:error_descr]
      end

      def error_string
        "(#{error_code}) #{error_description}"
      end

      def raise_error
        case error_code
        when 'BE103'
          raise NotLoggedInError, error_string
        when 'BE118'
          raise AlreadyLoggedInError, error_string
        else
          raise BrokerError, error_string
        end
      end
    end
  end
end
