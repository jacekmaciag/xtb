# frozen_string_literal: true

require 'active_support'
require_relative 'config'

module Xtb
  # Module provides a mechanism to limit the number of requests to the broker server.
  module RequestQueue
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods # :nodoc:
      private

      def with_request_queue(&block)
        queue.push(block)
        queue.push(wait_proc)

        result = queue.pop.call
        queue.pop.call

        result
      end

      def queue
        @queue ||= Queue.new
      end

      def wait_proc
        proc { sleep(min_request_interval) }
      end

      def min_request_interval
        Config.min_request_interval
      end
    end
  end
end
