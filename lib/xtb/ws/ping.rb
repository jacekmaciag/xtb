# frozen_string_literal: true

module Xtb
  module Ws
    # http://developers.xstore.pro/documentation/2.5.0#streamgetCandles
    class Ping < Subscription
      StreamingCandleRecord = Data.define(:close, :ctm, :ctm_string, :high, :low, :open, :quote_id, :symbol, :volume)

      # @param symbol [String] The symbol to subscribe to.
      def initialize(symbol:)
        @symbol = symbol
      end

      private

      attr_reader :symbol

      def sub_command = :getCandles
      def unsub_command = :stopCandles

      def arguments
        {
          symbol: symbol.upcase
        }
      end
    end
  end
end
