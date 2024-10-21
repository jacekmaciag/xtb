# frozen_string_literal: true

RSpec.describe Xtb::Http::Calendar do
  subject(:command) { described_class.new }

  let(:response) do
    JSON.dump(
      {
        'status': true,
        'return_data': [
          {
            'country': 'CA',
            'current': '',
            'forecast': '',
            'impact': '3',
            'period': '(FEB)',
            'previous': '58.3',
            'time': 1_374_846_900_000,
            'title': 'Ivey Purchasing Managers Index'
          }
        ]
      }
    )
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do
      expect(Xtb::Http::SslClient)
        .to receive(:request)
        .with(JSON.dump(command: :getCalendar))
        .and_return(response)
      expect(call.last)
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
