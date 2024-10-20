# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getServerTime
    class ServerTime < Command
      ServerTimeResponse = Data.define(:time, :time_string)

      def call
        ServerTimeResponse.new(**super)
      end

      private

      def command = :getServerTime
    end
  end
end
