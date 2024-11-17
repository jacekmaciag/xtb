# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::MarginTrade do
  subject(:command) { described_class.new(symbol, volume) }

  let(:symbol) { 'EURPLN' }
  let(:volume) { 1.0 }

  include_context('with xtb client stub') do
    let(:request) do
      JSON.dump(
        {
          command: :getMarginTrade,
          arguments: {
            symbol: 'EURPLN',
            volume: 1.0
          }
        }
      )
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
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do
      expect(call)
        .to have_attributes(
          margin: 4399.350
        )
    end
  end
end
