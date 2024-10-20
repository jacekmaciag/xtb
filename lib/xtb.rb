# frozen_string_literal: true

require_relative 'xtb/version'
require_relative 'xtb/http'
require_relative 'xtb/web_socket'
require_relative 'xtb/config'

module Xtb
  PERIOD = {
    m1: 1,
    m5: 5,
    m15: 15,
    m30: 30,
    h1: 60,
    h4: 240,
    d1: 1440,
    w1: 10_080,
    mn1: 43_200
  }.freeze

  OPERATION = {
    buy: 0,
    sell: 1,
    buy_limit: 2,
    sell_limit: 3,
    buy_stop: 4,
    sell_stop: 5,
    balance: 6,
    credit: 7
  }.freeze
end
