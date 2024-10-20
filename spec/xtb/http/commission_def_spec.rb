# frozen_string_literal: true

RSpec.describe Xtb::Http::CommissionDef do
  subject(:command) { described_class.new(symbol, volume) }

  let(:symbol) { 'T.US' }
  let(:volume) { 1.0 }

  let(:request) do
    {
      command: :getCommissionDef,
      arguments: {
        symbol:,
        volume:
      }
    }
  end
  let(:response) do
    JSON.dump(
      {
        'status': true,
        'return_data': {
          'commission': 0.51,
          'rateOfExchange': 0.1609
        }
      }
    )
  end

  describe '#call' do
    specify do
      expect(Xtb::Http::SslClient)
        .to receive(:request)
        .with(JSON.dump(request))
        .and_return(response)
      expect(command.call)
        .to have_attributes(
          commission: 0.51,
          rate_of_exchange: 0.1609
        )
    end
  end
end
