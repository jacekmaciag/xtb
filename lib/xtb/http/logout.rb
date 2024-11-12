# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#logout
    class Logout < Command
      private

      def command = :logout
    end
  end
end
