# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getCommissionDef
    class CommissionDef < Command
      CommissionDefResponse = Data.define(:commission, :rate_of_exchange)

      # @param symbol [String|Symbol]
      # @param volume [Float]
      def initialize(symbol, volume)
        @symbol = symbol
        @volume = volume
      end

      def call
        CommissionDefResponse.new(**super.return_data)
      end

      private

      attr_reader :symbol, :volume

      def command = :getCommissionDef

      def arguments
        {
          symbol:,
          volume:
        }
      end
    end
  end
end
