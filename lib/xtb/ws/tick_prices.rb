# frozen_string_literal: true

module Xtb
  module Ws
    # Client for WebSocket connection.
    class TickPrices < Subscription
      # @param symbol [String] The symbol to subscribe to.
      # @param min_arrival_time [Integer] This field is optional and defines the minimal interval in milliseconds
      #   between any two consecutive updates. If this field is not present, or it is set to 0 (zero),
      #   ticks - if available - are sent to the client with interval equal to 200 milliseconds.
      #   In order to obtain ticks as frequently as server allows you, set it to 1 (one).
      # @param max_level [Integer] This field is optional and specifies the maximum level of the quote that the user
      #   is interested in. If this field is not specified, the subscription is active for all levels that are
      #   managed in the system.
      def initialize(symbol:, min_arrival_time: nil, max_level: nil)
        @symbol = symbol
        @min_arrival_time = min_arrival_time
        @max_level = max_level
      end

      private

      attr_reader :symbol, :min_arrival_time, :max_level

      def sub_command = :getTickPrices
      def unsub_command = :stopTickPrices

      def arguments
        {
          maxLevel: max_level,
          minArrivalTime: min_arrival_time,
          symbol: symbol.upcase
        }.compact
      end
    end
  end
end
