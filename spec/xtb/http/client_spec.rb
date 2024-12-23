# frozen_string_literal: true

require 'openssl'

RSpec.describe Xtb::Http::Client do
  pending 'Needs a fix for the SSL socket connection.'

  subject(:client) { described_class.new }

  let(:raw_request) { '{"command":"getSomething"}' }
  let(:raw_response) { '{"status":true,"return_data":{"key":"value"}}' }

  describe '.post' do
    let(:raw_login_request) { '{"command":"login","arguments":{"userId":"user_id","password":"password"}}' }
    let(:raw_login_response) { '{"status":true,"streamSessionId":"stream_session_id"}' }

    let(:client_instance) { instance_double(described_class) }

    before do
      allow(Xtb).to receive_messages(user_id: 'user_id', password: 'password')

      allow(described_class).to receive(:new).and_return(client_instance)
      allow(client_instance).to receive(:request).with(raw_login_request).and_return(raw_login_response)
      allow(client_instance).to receive(:request).with(raw_request).and_return(raw_response)
      allow(client_instance).to receive(:stream_session_id=)
    end

    specify 'yields the client instance' do
      expect { |b| described_class.post(&b) }
        .to yield_with_args(client_instance)
    end
  end

  describe '#request' do
    subject(:request) { client.request(raw_request) }

    let(:socket_instance) { instance_double(OpenSSL::SSL::SSLSocket) }

    before do
      allow(OpenSSL::SSL::SSLSocket).to receive(:new).and_return(socket_instance)
      allow(socket_instance).to receive(:hostname=)
      allow(socket_instance).to receive(:sync_close=)
      allow(socket_instance).to receive(:connect).and_return(socket_instance)
      allow(socket_instance).to receive(:puts).with(raw_request)
      allow(socket_instance).to receive(:gets).and_return(raw_response, "\n")
    end

    specify 'returns the response' do
      expect(request).to eq(raw_response)
    end
  end
end
