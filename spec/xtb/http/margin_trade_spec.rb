# frozen_string_literal: true

RSpec.describe Xtb::Http::MarginTrade do
  subject(:command) { described_class.new(symbol, volume) }

  let(:symbol) { 'EURPLN' }
  let(:volume) { 1.0 }

  let(:request) do
    {
      command: :getMarginTrade,
      arguments: {
        symbol: 'EURPLN',
        volume: 1.0
      }
    }
  end
  let(:response) do
    JSON.dump(
      {
        'status': true,
        'returnData': {
          'margin': 4399.350
        }
      }
    )
  end

  describe '#call' do
    before do
      allow(Xtb::Http::SslClient).to receive(:request).and_return(response)
    end

    specify do
      expect(Xtb::Http::SslClient)
        .to receive(:request)
              .with(JSON.dump(request))
              .and_return(response)
      expect(command.call)
        .to have_attributes(
              margin: 4399.350
            )
    end
  end
end
