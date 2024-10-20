# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getCalendar
    class Calendar < Command
      IMPACT = {
        1 => 'low',
        2 => 'medium',
        3 => 'high'
      }.freeze

      CalendarRecord = Data.define(:country, :current, :forecast, :impact, :period, :previous, :time, :title) do
        def initialize(country:, current:, forecast:, impact:, period:, previous:, time:, title:)
          super(country:, current:, forecast:, impact: IMPACT[impact.to_i], period:, previous:, time:, title:)
        end
      end

      def call
        super.map { |record| CalendarRecord.new(**record) }
      end

      private

      def command = :getCalendar
    end
  end
end
