# frozen_string_literal: true

require_relative 'xtb/version'
require_relative 'xtb/error'
require_relative 'xtb/http'
require_relative 'xtb/web_socket'
require_relative 'xtb/config'

module Xtb
  # Periods in minutes.
  PERIODS = {
    m1: 1,
    m5: 5,
    m15: 15,
    m30: 30,
    h1: 60,
    h4: 240,
    d1: 1_440,
    w1: 10_080,
    mn1: 43_200
  }.freeze

  # Operations with XTB broker codes.
  OPERATIONS = {
    buy: 0,
    sell: 1,
    buy_limit: 2,
    sell_limit: 3,
    buy_stop: 4,
    sell_stop: 5,
    balance: 6,
    credit: 7
  }.freeze

  # Trade transaction type with XTB broker codes.
  TRADE_TRANSACTION_TYPES = {
    open: 0,
    pending: 1,
    close: 2,
    modify: 3,
    delete: 4
  }.freeze

  SymbolRecord = Data.define(:ask, :bid, :category_name, :contract_size, :currency, :currency_pair, :currency_profit,
                             :description, :exemode, :expiration, :group_name, :high, :initial_margin,
                             :instant_max_volume, :leverage, :long_only, :lot_max, :lot_min, :lot_step, :low,
                             :margin_hedged, :margin_hedged_strong, :margin_maintenance, :margin_mode, :percentage,
                             :pips_precision, :precision, :profit_mode, :quote_id, :quote_id_cross, :short_selling,
                             :spread_raw, :spread_table, :starting, :step_rule_id, :stops_level, :swap_rollover3days,
                             :swap_enable, :swap_long, :swap_short, :swap_type, :symbol, :tick_size, :tick_value,
                             :time, :time_string, :trailing_enabled, :type)

  TradeRecord = Data.define(:close_price, :close_time, :close_time_string, :closed, :cmd, :comment, :commission,
                            :custom_comment, :digits, :expiration, :expiration_string, :margin_rate, :offset,
                            :open_price, :open_time, :open_time_string, :order, :order2, :position, :profit, :sl,
                            :storage, :symbol, :timestamp, :tp, :volume)
end
