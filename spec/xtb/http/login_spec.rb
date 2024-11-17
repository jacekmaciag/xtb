# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::Login do
  subject(:command) { described_class.new }

  include_context('with xtb client stub') do
    let(:request) do
      JSON.dump(
        {
          command: :login,
          arguments: {
            userId: 'user_id',
            password: 'password'
          }
        }
      )
    end
    let(:response) do
      JSON.dump(
        {
          'status': true,
          'streamSessionId': 'stream_session_id'
        }
      )
    end
  end

  before do
    allow(Xtb::Config).to receive_messages(user_id: 'user_id', password: 'password')
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do
      expect(call)
        .to have_attributes(
          stream_session_id: 'stream_session_id'
        )
    end
  end
end
