# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getProfitCalculation
    class ProfitCalculation < Command
      ProfitCalculationResponse = Data.define(:profit)

      # @param close_price [Float]
      # @param cmd [Xtb::OPERATION]
      # @param open_price [Float]
      # @param symbol [String|Symbol]
      # @param volume [Float]
      def initialize(close_price, cmd, open_price, symbol, volume)
        @close_price = close_price
        @cmd = cmd
        @open_price = open_price
        @symbol = symbol
        @volume = volume
      end

      def call
        ProfitCalculationResponse.new(**super)
      end

      private

      attr_reader :close_price, :cmd, :open_price, :symbol, :volume

      def command = :getProfitCalculation

      def arguments
        {
          close_price:,
          cmd: Xtb::OPERATION[cmd],
          open_price:,
          symbol:,
          volume:
        }
      end
    end
  end
end
