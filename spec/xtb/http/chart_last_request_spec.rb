# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::ChartLastRequest do
  subject(:command) { described_class.new(period, start, symbol) }

  let(:period) { Xtb::PERIODS[:m5] }
  let(:start) { 1_272_529_161_605 }
  let(:symbol) { 'KOMB.CZ' }

  include_context('with xtb client stub') do
    let(:request) do
      JSON.dump(
        {
          command: :getChartLastRequest,
          arguments: {
            info: {
              period: 5,
              start:,
              symbol:
            }
          }
        }
      )
    end
    let(:response) do
      JSON.dump(
        {
          'status': true,
          'return_data': {
            'digits': 4,
            'rateInfos': [
              {
                "close": 1.0,
                "ctm": 1_389_362_640_000,
                "ctmString": 'Jan 10, 2014 3:04:00 PM',
                "high": 6.0,
                "low": 0.0,
                "open": 41_848.0,
                "vol": 0.0
              }
            ]
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
          digits: 4,
          rate_infos: [
            have_attributes(
              close: 1.0,
              ctm: 1_389_362_640_000,
              ctm_string: 'Jan 10, 2014 3:04:00 PM',
              high: 6.0,
              low: 0.0,
              open: 41_848.0,
              vol: 0.0
            )
          ]
        )
    end
  end
end
