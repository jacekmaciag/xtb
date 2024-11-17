# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getTrades
    class TradesHistory < Command
      # @param end_time [Time]
      # @param start_time [Time]
      def initialize(end_time, start_time)
        @end_time = end_time
        @start_time = start_time

        super()
      end

      def call
        super.return_data.map { |record| Xtb::TradeRecord.new(**record) }
      end

      private

      attr_reader :end_time, :start_time

      def command = :getTradesHistory

      def arguments
        {
          end: end_time,
          start: start_time
        }
      end
    end
  end
end
