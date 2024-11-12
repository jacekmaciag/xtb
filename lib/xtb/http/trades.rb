# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getTrades
    class Trades < Command
      # @param opened_only [Boolean]
      def initialize(opened_only)
        @opened_only = opened_only
      end

      def call
        super.return_data.map { |record| Xtb::TradeRecord.new(**record) }
      end

      private

      attr_reader :opened_only

      def command = :getTrades

      def arguments
        {
          opened_only:
        }
      end
    end
  end
end
