# frozen_string_literal: true

require 'json'
require 'active_support/inflector'
require_relative '../error'

module Xtb
  module Http
    # Base class for all commands.
    class Command
      Request = Struct.new(:command, :arguments) do
        def to_json(*_args)
          arguments = transform_keys(self.arguments) if self.arguments
          JSON.dump({ command:, arguments: }.compact)
        end

        private

        def transform_keys(hash)
          hash.transform_keys! do |key|
            key.to_s.camelize(:lower)
          end

          hash.transform_values do |value|
            transform_keys(value) if value.is_a?(Hash)
            value
          end
        end
      end

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
          response = JSON.parse(raw_response)
          transform_keys(response)
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

      def initialize(**args); end

      def self.call(**args)
        new(**args).call
      end

      def call
        request_data = Request.new(command:, arguments:).to_json
        raw_response = Client.post(request_data)
        response = Response.new(command:, raw_response:)
        raise_error(response.error_code, response.error_description) unless response.success?

        response
      end

      private

      def command
        raise NotImplementedError('You must implement the command method')
      end

      def arguments
        nil
      end

      def raise_error(error_code, error_description)
        case error_code
        when 'BE103'
          raise NotLoggedInError, "(#{error_code}) #{error_description}"
        when 'BE118'
          raise AlreadyLoggedInError, "(#{error_code}) #{error_description}"
        else
          raise "(#{error_code}) #{error_description}"
        end
      end
    end
  end
end
