# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::News do
  subject(:command) { described_class.new(end_time, start_time) }

  let(:end_time) { 0 }
  let(:start_time) { 1_275_993_488_000 }

  include_context('with xtb client stub') do
    let(:request) do
      JSON.dump(
        {
          command: :getNews,
          arguments: {
            endTime: 0,
            startTime: 1_275_993_488_000
          }
        }
      )
    end
    let(:response) do
      JSON.dump(
        {
          'status': true,
          'returnData': [
            {
              'body': '<html>...</html>',
              'bodylen': 110,
              'key': '1f6da766abd29927aa854823f0105c23',
              'time': 1_262_944_112_000,
              'timeString': 'May 17, 2013 4:30:00 PM',
              'title': 'Breaking trend'
            }
          ]
        }
      )
    end
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do # rubocop:disable RSpec/ExampleLength
      expect(call)
        .to contain_exactly(
          have_attributes(
            body: '<html>...</html>',
            bodylen: 110,
            key: '1f6da766abd29927aa854823f0105c23',
            time: 1_262_944_112_000,
            time_string: 'May 17, 2013 4:30:00 PM',
            title: 'Breaking trend'
          )
        )
    end
  end
end
