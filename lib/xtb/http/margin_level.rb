# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getMarginLevel
    class MarginLevel < Command
      MarginLevelResponse = Data.define(:balance, :credit, :currency, :equity, :margin, :margin_free, :margin_level)

      def call
        MarginLevelResponse.new(**super)
      end

      private

      def command = :getMarginLevel
    end
  end
end
