# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::Symbol do
  subject(:command) { described_class.new(symbol) }

  let(:symbol) { 'USDPLN' }

  include_context('with xtb client stub') do
    let(:request) do
      JSON.dump(
        {
          command: :getSymbol,
          arguments: {
            symbol:
          }
        }
      )
    end
    let(:response) do
      JSON.dump(
        {
          'status': 1,
          'returnData': {
            'ask': 4000.0,
            'bid': 4000.0,
            'categoryName': 'Forex',
            'contractSize': 100_000,
            'currency': 'USD',
            'currencyPair': true,
            'currencyProfit': 'PLN',
            'description': 'USD/PLN',
            'exemode': 0,
            'expiration': nil,
            'groupName': 'Minor',
            'high': 4000.0,
            'initialMargin': 0,
            'instantMaxVolume': 0,
            'leverage': 1.5,
            'longOnly': false,
            'lotMax': 10.0,
            'lotMin': 0.1,
            'lotStep': 0.1,
            'low': 3500.0,
            'marginHedged': 0,
            'marginHedgedStrong': false,
            'marginMaintenance': nil,
            'marginMode': 101,
            'percentage': 100.0,
            'pipsPrecision': 2,
            'precision': 2,
            'profitMode': 5,
            'quoteId': 1,
            'quoteIdCross': 1,
            'shortSelling': true,
            'spreadRaw': 0.000003,
            'spreadTable': 0.00042,
            'starting': nil,
            'stepRuleId': 1,
            'stopsLevel': 0,
            'swap_rollover3days': 0,
            'swapEnable': true,
            'swapLong': -2.55929,
            'swapShort': 0.131,
            'swapType': 0,
            'symbol': 'USDPLN',
            'tickSize': 1.0,
            'tickValue': 1.0,
            'time': 1_272_446_136_891,
            'timeString': 'Thu May 23 12:23:44 EDT 2013',
            'trailingEnabled': true,
            'type': 21
          }
        }
      )
    end
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do # rubocop:disable RSpec/ExampleLength
      expect(call)
        .to have_attributes(
          ask: 4000.0,
          bid: 4000.0,
          category_name: 'Forex',
          contract_size: 100_000,
          currency: 'USD',
          currency_pair: true,
          currency_profit: 'PLN',
          description: 'USD/PLN',
          exemode: 0,
          expiration: nil,
          group_name: 'Minor',
          high: 4000.0,
          initial_margin: 0,
          instant_max_volume: 0,
          leverage: 1.5,
          long_only: false,
          lot_max: 10.0,
          lot_min: 0.1,
          lot_step: 0.1,
          low: 3500.0,
          margin_hedged: 0,
          margin_hedged_strong: false,
          margin_maintenance: nil,
          margin_mode: 101,
          pips_precision: 2,
          percentage: 100.0,
          precision: 2,
          profit_mode: 5,
          quote_id: 1,
          quote_id_cross: 1,
          short_selling: true,
          spread_raw: 0.000003,
          spread_table: 0.00042,
          starting: nil,
          step_rule_id: 1,
          stops_level: 0,
          swap_rollover3days: 0,
          swap_enable: true,
          swap_long: -2.55929,
          swap_short: 0.131,
          swap_type: 0,
          symbol: 'USDPLN',
          tick_size: 1.0,
          tick_value: 1.0,
          time: 1_272_446_136_891,
          time_string: 'Thu May 23 12:23:44 EDT 2013',
          trailing_enabled: true,
          type: 21
        )
    end
  end
end
