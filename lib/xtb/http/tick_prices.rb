# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getTickPrices
    class TickPrices < Command
      TickRecord = Data.define(:ask, :ask_volume, :bid, :bid_volume, :high, :level, :low, :spread_raw, :spread_table,
                               :symbol, :timestamp)

      def initialize(level, symbols, timestamp)
        @level = level
        @symbols = symbols
        @timestamp = timestamp
      end

      def call
        super[:quotations].map { |record| TickRecord.new(**record) }
      end

      private

      attr_reader :level, :symbols, :timestamp

      def command = :getTickPrices

      def arguments
        {
          level:,
          symbols:,
          timestamp:
        }
      end
    end
  end
end
