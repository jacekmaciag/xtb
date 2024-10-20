# frozen_string_literal: true

RSpec.describe Xtb::Http::MarginLevel do
  subject(:command) { described_class.new }

  let(:response) do
    JSON.dump(
      {
        'status': true,
        'returnData': {
          'balance': 995_800_269.43,
          'credit': 1000.00,
          'currency': 'PLN',
          'equity': 995_985_397.56,
          'margin': 572_634.43,
          'margin_free': 995_227_635.00,
          'margin_level': 173_930.41
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
        .with(JSON.dump(command: :getMarginLevel))
        .and_return(response)
      expect(command.call)
        .to have_attributes(
          balance: 995_800_269.43,
          credit: 1000.00,
          currency: 'PLN',
          equity: 995_985_397.56,
          margin: 572_634.43,
          margin_free: 995_227_635.00,
          margin_level: 173_930.41
        )
    end
  end
end
