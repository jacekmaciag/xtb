# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::ServerTime do
  subject(:command) { described_class.new }

  include_context('with xtb client stub') do
    let(:request) { JSON.dump(command: :getServerTime) }
    let(:response) do
      JSON.dump(
        {
          'status': true,
          'return_data':
            {
              'time': 1_392_211_379_731,
              'timeString': 'Feb 12, 2014 2:22:59 PM'
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
          time: 1_392_211_379_731,
          time_string: 'Feb 12, 2014 2:22:59 PM'
        )
    end
  end
end
