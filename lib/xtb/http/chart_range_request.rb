# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/current#getChartRangeRequest
    class ChartRangeRequest < Command
      RateInfoRecord = Data.define(:close, :ctm, :ctm_string, :high, :low, :open, :vol)
      ChartLastRequestResponse = Data.define(:digits, :rate_infos)

      # @param end_time [Time] End of chart block
      # @param period [Xtb::Period] Period code
      # @param start_time [Time] Start of chart block
      # @param symbol [String|Symbol] Symbol
      # @param ticks [Integer] (Optional) Number of ticks needed
      def initialize(end_time, period, start_time, symbol, ticks: nil)
        @end_time = end_time
        @period = period
        @start_time = start_time
        @symbol = symbol
        @ticks = ticks
      end

      def call
        digits, rate_infos = super.values_at(:digits, :rate_infos)
        rate_infos = rate_infos.map { |record| RateInfoRecord.new(**record) }
        ChartLastRequestResponse.new(digits:, rate_infos:)
      end

      private

      attr_reader :end_time, :period, :start_time, :symbol, :ticks

      def command = :getChartRangeRequest

      def arguments
        {
          info:
            {
              end: end_time,
              period:,
              start: start_time,
              symbol:,
              ticks:
            }.compact
        }
      end
    end
  end
end
