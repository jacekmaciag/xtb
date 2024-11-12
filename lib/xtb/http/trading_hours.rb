# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getTradingHours
    class TradingHours < Command
      # Represents both quotes and trading times records.
      TimesRecord = Data.define(:day, :from_t, :to_t)

      TradingHoursRecord = Data.define(:quotes, :symbol, :trading) do
        def initialize(symbol:, quotes: TimesRecord.new, trading: TimesRecord.new)
          super(quotes:, symbol:, trading:)
        end
      end

      # @param symbols [Array<String|Symbol>]
      def initialize(symbols)
        @symbols = symbols
      end

      def call
        super.return_data.map { |record| TradingHoursRecord.new(**record) }
      end

      private

      attr_reader :symbols

      def command = :getTradingHours

      def arguments
        {
          symbols:
        }
      end
    end
  end
end
