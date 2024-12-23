# frozen_string_literal: true

module Xtb
  module Ws
    # http://developers.xstore.pro/documentation/2.5.0#streamgetProfits
    class Profits < Subscription
      StreamingProfitRecord = Data.define(:order, :order_2, :position, :profit)

      private

      def sub_command = :getProfits
      def unsub_command = :stopProfits
    end
  end
end
