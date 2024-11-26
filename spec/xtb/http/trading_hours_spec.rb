# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::TradingHours do
  subject(:command) { described_class.new(symbols) }

  let(:symbols) { %w[EURUSD] }

  include_context('with xtb client stub') do
    let(:request) do
      JSON.dump(
        {
          command: :getTradingHours,
          arguments: {
            symbols:
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
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do  # rubocop:disable RSpec/ExampleLength
      expect(call.first)
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
