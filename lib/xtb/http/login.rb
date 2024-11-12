# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#login
    class Login < Command
      LoginResponse = Data.define(:stream_session_id)

      def call
        LoginResponse.new(super.stream_session_id)
      end

      private

      def command = :login

      def arguments
        {
          user_id:,
          password:
        }
      end

      def user_id
        Xtb::Config.user_id
      end

      def password
        Xtb::Config.password
      end
    end
  end
end
