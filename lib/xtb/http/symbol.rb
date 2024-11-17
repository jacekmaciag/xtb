# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getSymbol
    class Symbol < Command
      # @param symbol [String|Symbol]
      def initialize(symbol)
        @symbol = symbol

        super()
      end

      def call
        Xtb::SymbolRecord.new(**super.return_data)
      end

      private

      attr_reader :symbol

      def command = :getSymbol

      def arguments
        {
          symbol:
        }
      end
    end
  end
end
