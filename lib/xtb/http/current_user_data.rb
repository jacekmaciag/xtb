# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getCurrentUserData
    class CurrentUserData < Command
      CurrentUserDataResponse = Data.define(:company_unit, :currency, :group, :ib_account, :leverage,
                                            :leverage_multiplier, :spread_type, :trailing_stop)

      def call
        CurrentUserDataResponse.new(**super.return_data)
      end

      private

      def command = :getCurrentUserData
    end
  end
end
