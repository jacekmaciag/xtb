# frozen_string_literal: true

module Xtb
  module Ws
    # http://developers.xstore.pro/documentation/2.5.0#streamgetKeepAlive
    class KeepAlive < Subscription
      StreamingKeepAliveRecord = Data.define(:timestamp)

      private

      def sub_command = :getKeepAlive
      def unsub_command = :stopKeepAlive
    end
  end
end
