# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::ProfitCalculation do
  subject(:command) { described_class.new(close_price, cmd, open_price, symbol, volume) }

  let(:close_price) { 1.3000 }
  let(:cmd) { :buy }
  let(:open_price) { 1.2233 }
  let(:symbol) { 'EURPLN' }
  let(:volume) { 1.0 }

  include_context('with xtb client stub') do
    let(:request) do
      JSON.dump(
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
      )
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
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do
      expect(call)
        .to have_attributes(
          profit: 0.0767
        )
    end
  end
end
