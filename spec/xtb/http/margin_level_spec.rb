# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::MarginLevel do
  subject(:command) { described_class.new }

  include_context('with xtb client stub') do
    let(:request) { JSON.dump(command: :getMarginLevel) }
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
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do # rubocop:disable RSpec/ExampleLength
      expect(call)
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
