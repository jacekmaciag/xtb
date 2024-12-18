# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::TickPrices do
  subject(:command) { described_class.new(level, symbols, timestamp) }

  let(:level) { 0 }
  let(:symbols) { 'KOMB.CZ' }
  let(:timestamp) { 1_272_529_161_605 }

  include_context('with xtb client stub') do
    let(:request) do
      JSON.dump(
        {
          command: :getTickPrices,
          arguments: {
            level:,
            symbols:,
            timestamp:
          }
        }
      )
    end
    let(:response) do
      JSON.dump(
        {
          'status': true,
          'return_data': {
            'quotations': [
              {
                'ask': 4000.0,
                'askVolume': 15_000,
                'bid': 4000.0,
                'bidVolume': 16_000,
                'high': 4000.0,
                'level': 0,
                'low': 3500.0,
                'spreadRaw': 0.000003,
                'spreadTable': 0.00042,
                'symbol': 'KOMB.CZ',
                'timestamp': 1_272_529_161_605
              }
            ]
          }
        }
      )
    end
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do # rubocop:disable RSpec/ExampleLength
      expect(call.last)
        .to have_attributes(
          ask: 4000.0,
          ask_volume: 15_000,
          bid: 4000.0,
          bid_volume: 16_000,
          high: 4000.0,
          level: 0,
          low: 3500.0,
          spread_raw: 0.000003,
          spread_table: 0.00042,
          symbol: 'KOMB.CZ',
          timestamp: 1_272_529_161_605
        )
    end
  end
end
