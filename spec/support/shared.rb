# frozen_string_literal: true

RSpec.shared_context 'with http client returning' do |response|
  let(:http_client) { instance_double('Xtb::HttpClient') }

  before do
    allow(Xtb::Client).to receive(:new).and_return(http_client)
    allow(http_client).to receive(:post).and_return(response)
  end
end
