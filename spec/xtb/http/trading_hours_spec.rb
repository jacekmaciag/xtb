# frozen_string_literal: true

RSpec.describe Xtb::Http::TradingHours do
  subject(:command) { described_class.new(symbols) }

  let(:symbols) { %w[EURUSD] }

  let(:request) do
    {
      command: :getTradingHours,
      arguments: {
        symbols:
      }
    }
  end
  let(:response) do
    JSON.dump(
      {
        'status': true,
        'return_data': [
          {
            'quotes': {
              'day': 2,
              'from_t': 63_000_000,
              'to_t': 63_300_000
            },
            'symbol': 'EURUSD',
            'trading': {
              'day': 2,
              'from_t': 63_000_000,
              'to_t': 63_300_000
            }
          }
        ]
      }
    )
  end

  describe '#call' do
    specify do
      expect(Xtb::Http::SslClient)
        .to receive(:request)
        .with(JSON.dump(request))
        .and_return(response)
      expect(command.call.first)
        .to have_attributes(
          quotes: {
            day: 2,
            from_t: 63_000_000,
            to_t: 63_300_000
          },
          symbol: 'EURUSD',
          trading: {
            day: 2,
            from_t: 63_000_000,
            to_t: 63_300_000
          }
        )
    end
  end
end
