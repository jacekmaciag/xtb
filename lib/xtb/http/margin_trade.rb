# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getMarginTrade
    class MarginTrade < Command
      MarginTradeResponse = Data.define(:margin)

      # @param symbol [String|Symbol]
      # @param volume [Float]
      def initialize(symbol, volume)
        @symbol = symbol
        @volume = volume
      end

      def call
        MarginTradeResponse.new(**super)
      end

      private

      attr_reader :symbol, :volume

      def command = :getMarginTrade

      def arguments
        {
          symbol:,
          volume:
        }
      end
    end
  end
end
