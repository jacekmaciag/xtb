# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::Calendar do
  subject(:command) { described_class.new }

  include_context('with xtb client stub') do
    let(:request) { JSON.dump(command: :getCalendar) }
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
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do
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
