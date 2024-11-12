# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getStepRules
    class StepRules < Command
      StepRecord = Data.define(:from_value, :step)

      def call
        super.return_data.map { |record| StepRecord.new(**record) }
      end

      private

      def command = :getStepRules
    end
  end
end
