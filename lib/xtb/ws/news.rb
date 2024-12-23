# frozen_string_literal: true

module Xtb
  module Ws
    # http://developers.xstore.pro/documentation/2.5.0#streamgetNews
    class News < Subscription
      StreamingNewsRecord = Data.define(:body, :key, :time, :title)

      private

      def sub_command = :getNews
      def unsub_command = :stopNews
    end
  end
end
