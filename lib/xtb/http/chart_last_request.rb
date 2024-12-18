# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getChartLastRequest
    class ChartLastRequest < Command
      RateInfoRecord = Data.define(:close, :ctm, :ctm_string, :high, :low, :open, :vol)
      ChartLastRequestResponse = Data.define(:digits, :rate_infos)

      # @param period [Xtb::PERIODS]
      # @param start [Time]
      # @param symbol [String|Symbol]
      def initialize(period, start, symbol)
        @period = period
        @start = start
        @symbol = symbol

        super()
      end

      def call
        digits, rate_infos = super.return_data.values_at(:digits, :rate_infos)
        rate_infos = rate_infos.map { |record| RateInfoRecord.new(**record) }
        ChartLastRequestResponse.new(digits:, rate_infos:)
      end

      private

      attr_reader :period, :start, :symbol

      def command = :getChartLastRequest

      def arguments
        {
          info:
          {
            period:,
            start:,
            symbol:
          }
        }
      end
    end
  end
end
