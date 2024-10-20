# frozen_string_literal: true

RSpec.describe Xtb::Http::ServerTime do
  subject(:command) { described_class.new }

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

  describe '#call' do
    specify do
      expect(Xtb::Http::SslClient)
        .to receive(:request)
        .with(JSON.dump(command: :getServerTime))
        .and_return(response)
      expect(command.call)
        .to have_attributes(
          time: 1_392_211_379_731,
          time_string: 'Feb 12, 2014 2:22:59 PM'
        )
    end
  end
end
