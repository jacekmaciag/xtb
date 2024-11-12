# frozen_string_literal: true

RSpec.describe Xtb::Http::Login do
  subject(:command) { described_class.new }

  let(:request) do
    {
      command: :login,
      arguments: {
        userId: 'user_id',
        password: 'password'
      }
    }
  end
  let(:response) do
    JSON.dump(
      {
        'status': true,
        'streamSessionId': 'stream_session_id'
      }
    )
  end

  before do
    allow(Xtb::Config).to receive_messages(user_id: 'user_id', password: 'password')
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do
      expect(Xtb::Http::SslClient)
        .to receive(:request)
        .with(JSON.dump(request))
        .and_return(response)
      expect(call)
        .to have_attributes(
          stream_session_id: 'stream_session_id'
        )
    end
  end
end
