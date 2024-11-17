# frozen_string_literal: true

RSpec.shared_context 'with xtb client stub' do
  let(:http_client) { instance_double(Xtb::Http::Client) }

  before do
    allow(Xtb::Http::Client).to receive(:post).and_yield(http_client)
    allow(http_client).to receive(:request).with(request).and_return(response)
  end
end
