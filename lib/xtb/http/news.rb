# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getNews
    class News < Command
      NewsTopicRecord = Data.define(:body, :bodylen, :key, :time, :time_string, :title)

      # @param end_time [Time]
      # @param start_time [Time]
      def initialize(end_time, start_time)
        @end_time = end_time
        @start_time = start_time
      end

      def call
        super.return_data.map { |record| NewsTopicRecord.new(**record) }
      end

      private

      attr_reader :end_time, :start_time

      def command = :getNews

      def arguments
        {
          end_time:,
          start_time:
        }
      end
    end
  end
end
