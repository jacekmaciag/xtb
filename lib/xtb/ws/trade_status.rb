# frozen_string_literal: true

module Xtb
  module Ws
    # http://developers.xstore.pro/documentation/2.5.0#streamgetTradeStatus
    class TradeStatus < Subscription
      REQUEST_STATUS = {
        0 => 'ERROR',
        1 => 'PENDING',
        2 => 'ACCEPTED',
        3 => 'REJECTED'
      }.freeze

      StreamingTradeStatusRecord = Data.define(:custom_comment, :message, :order, :price, :request_status) do
        def request_status
          REQUEST_STATUS[super]
        end
      end

      private

      def sub_command = :getTradeStatus
      def unsub_command = :stopTradeStatus
    end
  end
end
