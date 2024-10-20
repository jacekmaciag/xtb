# frozen_string_literal: true

require_relative 'xtb/version'
require_relative 'xtb/http'
require_relative 'xtb/web_socket'
require_relative 'xtb/config'

module Xtb
  Period = {
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
end
