# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#tradeTransaction
    class TradeTransaction < Command
      TradeTransactionResponse = Data.define(:order)

      # @param cmd [Symbol]
      # @param custom_comment [String]
      # @param expiration [Integer]
      # @param offset [Integer]
      # @param order [Integer]
      # @param price [Float]
      # @param stop_loss [Float]
      # @param symbol [String]
      # @param take_profit [Float]
      # @param type [Symbol]
      # @param volume [Float]
      def initialize(cmd:, custom_comment:, expiration:, offset:, order:, price:, stop_loss:, symbol:, take_profit:,
                     type:, volume:)
        @cmd = cmd
        @custom_comment = custom_comment
        @expiration = expiration
        @offset = offset
        @order = order
        @price = price
        @stop_loss = stop_loss
        @symbol = symbol
        @take_profit = take_profit
        @type = type
        @volume = volume
      end

      def call
        TradeTransactionResponse.new(**super)
      end

      private

      attr_reader :cmd, :custom_comment, :expiration, :offset, :order, :price, :stop_loss, :symbol, :take_profit,
                  :type, :volume

      def command = :tradeTransaction

      def arguments
        {
          trade_trans_info: {
            cmd: Xtb::OPERATIONS[cmd],
            custom_comment:,
            expiration:,
            offset:,
            order:,
            price:,
            sl: stop_loss,
            symbol:,
            tp: take_profit,
            type: Xtb::TRADE_TRANSACTION_TYPES[type],
            volume:
          }
        }
      end
    end
  end
end
