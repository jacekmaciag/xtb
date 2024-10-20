# frozen_string_literal: true

module Xtb
  module Http
    # http://developers.xstore.pro/documentation/2.5.0#getAllSymbols
    class AllSymbols < Command
      Symbol = Data.define(:ask, :bid, :category_name, :contract_size, :currency, :currency_pair, :currency_profit,
                           :description, :exemode, :expiration, :group_name, :high, :initial_margin,
                           :instant_max_volume, :leverage, :long_only, :lot_max, :lot_min, :lot_step, :low,
                           :margin_hedged, :margin_hedged_strong, :margin_maintenance, :margin_mode, :percentage,
                           :pips_precision, :precision, :profit_mode, :quote_id, :quote_id_cross, :short_selling,
                           :spread_raw, :spread_table, :starting, :step_rule_id, :stops_level, :swap_rollover3days,
                           :swap_enable, :swap_long, :swap_short, :swap_type, :symbol, :tick_size, :tick_value,
                           :time, :time_string, :trailing_enabled, :type)

      def call
        super.map { |symbol| Symbol.new(**symbol) }
      end

      private

      def command = :getAllSymbols
    end
  end
end
