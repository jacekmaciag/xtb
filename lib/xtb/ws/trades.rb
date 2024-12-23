# frozen_string_literal: true

module Xtb
  module Ws
    # http://developers.xstore.pro/documentation/2.5.0#streamgetTrades
    class Trades < Subscription
      StreamingTradeRecord = Data.define

      private

      def sub_command = :getTrades
      def unsub_command = :stopTrades
    end
  end
end
