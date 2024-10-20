# frozen_string_literal: true

RSpec.describe Xtb::Http::ChartLastRequest do
  subject(:command) { described_class.new(period, start, symbol) }

  let(:period) { Xtb::PERIOD[:m5] }
  let(:start) { 1_272_529_161_605 }
  let(:symbol) { 'KOMB.CZ' }

  let(:request) do
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

  describe '#call' do
    specify do
      expect(Xtb::Http::SslClient)
        .to receive(:request)
        .with(JSON.dump(request))
        .and_return(response)
      expect(command.call)
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
