# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#ping
    class Ping < Command
      private

      def command = :ping
    end
  end
end
