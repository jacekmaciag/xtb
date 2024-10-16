# frozen_string_literal: true

RSpec.describe Xtb::Http::MarginLevel do
  subject(:command) { described_class.new }

  let(:response) do
    JSON.dump({
                'status' => true,
                'return_data' => {
                  'balance' => 1000.0,
                  'credit' => 0.0,
                  'currency' => 'USD',
                  'equity' => 1000.0,
                  'margin' => 0.0,
                  'margin_free' => 1000.0,
                  'margin_level' => 0.0
                }
              })
  end

  describe '#call' do
    before do
      allow(Xtb::Http::SslClient).to receive(:request).and_return(response)
    end

    specify do
      expect(command.call).to have_attributes(
        balance: 1000.0,
        credit: 0.0,
        currency: 'USD',
        equity: 1000.0,
        margin: 0.0,
        margin_free: 1000.0,
        margin_level: 0.0
      )
    end
  end
end
