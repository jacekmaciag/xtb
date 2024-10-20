# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getTradeRecords
    class TradeRecords < Command
      # @param orders [Array<Integer>] list of order ids
      def initialize(orders)
        @orders = orders
      end

      def call
        super.map { |record| Xtb::TradeRecord.new(**record) }
      end

      private

      attr_reader :orders

      def command = :getTradeRecords

      def arguments
        {
          orders:
        }
      end
    end
  end
end
