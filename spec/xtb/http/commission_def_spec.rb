# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::CommissionDef do
  subject(:command) { described_class.new(symbol, volume) }

  let(:symbol) { 'T.US' }
  let(:volume) { 1.0 }

  include_context('with xtb client stub') do
    let(:request) do
      JSON.dump(
        {
          command: :getCommissionDef,
          arguments: {
            symbol:,
            volume:
          }
        }
      )
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
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do
      expect(call)
        .to have_attributes(
          commission: 0.51,
          rate_of_exchange: 0.1609
        )
    end
  end
end
