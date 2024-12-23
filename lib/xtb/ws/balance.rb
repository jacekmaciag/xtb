# frozen_string_literal: true

module Xtb
  module Ws
    # http://developers.xstore.pro/documentation/2.5.0#streamgetBalance
    class Balance < Subscription
      StreamingBalanceRecord = Data.define(:balance, :credit, :equity, :margin, :margin_fee, :margin_level)

      private

      def sub_command = :getBalance
      def unsub_command = :stopBalance
    end
  end
end
