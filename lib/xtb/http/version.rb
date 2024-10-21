# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getVersion
    class Version < Command
      VersionResponse = Data.define(:version)

      def call
        VersionResponse.new(**super)
      end

      private

      def command = :getVersion
    end
  end
end
