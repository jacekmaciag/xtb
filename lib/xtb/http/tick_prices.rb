# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/current#getTickPrices
    class TickPrices < Command
      TickPrice = Data.define(:ask, :ask_volumne, :bid, bind_volumen, :high, :level, :low, :spread_raw, :spread_table,
                              :symbol, :timestamp)

      def initialize(level, symbols, timestamp)
        @level = level
        @symbols = symbols
        @timestamp = timestamp
      end

      def call
        super.map { |item| TickPrice.new(**item) }
      end

      private

      attr_reader :level, :symbols, :timestamp

      def command = :getMarginLevel

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
