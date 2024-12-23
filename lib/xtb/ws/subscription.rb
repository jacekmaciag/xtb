# frozen_string_literal: true

require_relative '../error'
require_relative '../error_factory'

module Xtb
  module Ws
    class Subscription
      def initialize(**args); end

      def self.subscribe(**args)
        new(**args).subscribe
      end

      def self.unsubscribe(**args)
        new(**args).unsubscribe
      end

      def subscribe
        Xtb::Ws::Client.post(arguments.merge(command: sub_command))
      end

      def unsubscribe
        Xtb::Ws::Client.post(arguments.merge(command: unsub_command))
      end

      private

      def sub_command
        raise NotImplementedError('You must implement the sub_command method')
      end

      def unsub_command
        raise NotImplementedError('You must implement the unsub_command method')
      end

      def client
        Xtb::Ws::Client
      end

      def arguments
        {}
      end
    end
  end
end
