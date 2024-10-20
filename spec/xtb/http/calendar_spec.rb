# frozen_string_literal: true

RSpec.describe Xtb::Http::Calendar do
  subject(:command) { described_class.new }

  let(:response) do
    JSON.dump(
      {
        "status": true,
        "return_data": [
          {
            "country": 'CA',
            "current": '',
            "forecast": '',
            "impact": '3',
            "period": '(FEB)',
            "previous": '58.3',
            "time": 1_374_846_900_000,
            "title": 'Ivey Purchasing Managers Index'
          }
        ]
      }
    )
  end

  describe '#call' do
    before do
      allow(Xtb::Http::SslClient).to receive(:request).and_return(response)
    end

    specify do
      expect(command.call.last)
        .to have_attributes(
          country: 'CA',
          current: '',
          forecast: '',
          impact: 'high',
          period: '(FEB)',
          previous: '58.3',
          time: 1_374_846_900_000,
          title: 'Ivey Purchasing Managers Index'
        )
    end
  end
end
