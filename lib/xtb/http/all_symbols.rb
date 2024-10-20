# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getAllSymbols
    class AllSymbols < Command
      def call
        super.map { |symbol| Xtb::SymbolRecord.new(**symbol) }
      end

      private

      def command = :getAllSymbols
    end
  end
end
