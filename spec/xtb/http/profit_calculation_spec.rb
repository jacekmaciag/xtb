# frozen_string_literal: true

RSpec.describe Xtb::Http::ProfitCalculation do
  subject(:command) { described_class.new(close_price, cmd, open_price, symbol, volume) }

  let(:close_price) { 1.3000 }
  let(:cmd) { :buy }
  let(:open_price) { 1.2233 }
  let(:symbol) { 'EURPLN' }
  let(:volume) { 1.0 }

  let(:request) do
    {
      command: :getProfitCalculation,
      arguments: {
        closePrice: close_price,
        cmd: 0,
        openPrice: open_price,
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
          'profit': 0.0767
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
          profit: 0.0767
        )
    end
  end
end
