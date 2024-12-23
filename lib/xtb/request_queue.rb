# frozen_string_literal: true

require 'active_support'
require_relative 'configuration'

module Xtb
  # Module provides a mechanism to limit the number of requests to the broker server.
  module RequestQueue
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods # :nodoc:
      def with_request_queue
        sleep(time_to_next_request / 1000) unless @last_request_time.nil?

        yield
      ensure
        @last_request_time = Time.now
      end

      private

      def time_to_next_request
        [0, min_request_interval - time_since_last_request].max.to_f
      end

      # @return [Integer] time elapsed since the last request in milliseconds
      def time_since_last_request
        (1000 * (@last_request_time - Time.now)).to_i.abs
      end

      def min_request_interval
        @min_request_interval ||= Xtb.min_request_interval
      end
    end
  end
end
