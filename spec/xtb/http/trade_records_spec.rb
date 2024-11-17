# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::TradeRecords do
  subject(:command) { described_class.new(orders) }

  let(:orders) { [7_497_776] }

  include_context('with xtb client stub') do
    let(:request) do
      JSON.dump(
        {
          command: :getTradeRecords,
          arguments: {
            orders:
          }
        }
      )
    end
    let(:response) do
      JSON.dump(
        {
          'status': true,
          'return_data': [
            {
              'close_price': 1.3256,
              'close_time': nil,
              'close_timeString': nil,
              'closed': false,
              'cmd': 0,
              'comment': 'Web Trader',
              'commission': 0.0,
              'customComment': 'Some text',
              'digits': 4,
              'expiration': nil,
              'expirationString': nil,
              'margin_rate': 0.0,
              'offset': 0,
              'open_price': 1.4,
              'open_time': 1_272_380_927_000,
              'open_timeString': 'Fri Jan 11 10:03:36 CET 2013',
              'order': 7_497_776,
              'order2': 1_234_567,
              'position': 1_234_567,
              'profit': -2196.44,
              'sl': 0.0,
              'storage': -4.46,
              'symbol': 'EURUSD',
              'timestamp': 1_272_540_251_000,
              'tp': 0.0,
              'volume': 0.10
            }
          ]
        }
      )
    end
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do
      expect(call.first)
        .to have_attributes(
          close_price: 1.3256,
          close_time: nil,
          close_time_string: nil,
          closed: false,
          cmd: 0,
          comment: 'Web Trader',
          commission: 0.0,
          custom_comment: 'Some text',
          digits: 4,
          expiration: nil,
          expiration_string: nil,
          margin_rate: 0.0,
          offset: 0,
          open_price: 1.4,
          open_time: 1_272_380_927_000,
          open_time_string: 'Fri Jan 11 10:03:36 CET 2013',
          order: 7_497_776,
          order2: 1_234_567,
          position: 1_234_567,
          profit: -2196.44,
          sl: 0.0,
          storage: -4.46,
          symbol: 'EURUSD',
          timestamp: 1_272_540_251_000,
          tp: 0.0,
          volume: 0.10
        )
    end
  end
end
