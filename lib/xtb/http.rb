# frozen_string_literal: true

require_relative 'http/client'
require_relative 'http/command'

# commands
require_relative 'http/all_symbols'
require_relative 'http/calendar'
require_relative 'http/chart_last_request'
require_relative 'http/chart_range_request'
require_relative 'http/commission_def'
require_relative 'http/current_user_data'
require_relative 'http/login'
require_relative 'http/logout'
require_relative 'http/margin_level'
require_relative 'http/margin_trade'
require_relative 'http/news'
require_relative 'http/ping'
require_relative 'http/profit_calculation'
require_relative 'http/server_time'
require_relative 'http/step_rules'
require_relative 'http/symbol'
require_relative 'http/tick_prices'
require_relative 'http/trade_records'
require_relative 'http/trade_transaction'
require_relative 'http/trades'
require_relative 'http/trades_history'
require_relative 'http/trading_hours'
require_relative 'http/version'

module Xtb
  module Http # :nodoc:
  end
end
