# frozen_string_literal: true

RSpec.describe Xtb::Http::TickPrices do
  subject(:command) { described_class.new(level, symbols, timestamp) }

  let(:level) { 0 }
  let(:symbols) { 'KOMB.CZ' }
  let(:timestamp) { 1_272_529_161_605 }

  let(:response) do
    JSON.dump(
      {
        'status': true,
        'return_data': {
          'quotations': [
            {
              'ask': 4000.0,
              'askVolume': 15000,
              'bid': 4000.0,
              'bidVolume': 16000,
              'high': 4000.0,
              'level': 0,
              'low': 3500.0,
              'spreadRaw': 0.000003,
              'spreadTable': 0.00042,
              'symbol': 'KOMB.CZ',
              'timestamp': 1272529161605
            }
          ]
        }
      }
    )
  end

  describe '#call' do
    before do
      allow(Xtb::Http::SslClient).to receive(:request).and_return(response)
    end

    specify do
      expect(command.call.last)
        .to have_attributes(
              ask: 4000.0,
              ask_volume: 15000,
              bid: 4000.0,
              bid_volume: 16000,
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
