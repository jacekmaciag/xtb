# frozen_string_literal: true

RSpec.describe Xtb do
  specify 'has a version number' do
    expect(Xtb::VERSION).not_to be_nil
  end

  describe 'configuration' do
    specify 'is initialized with default configuration' do
      expect(described_class)
        .to have_attributes(
          environment: :demo,
          https: have_attributes(
            host: 'xapi.xtb.com',
            port: 5124
          ),
          wss: have_attributes(
            host: 'ws.xtb.com',
            port: 5125,
            path: 'demo'
          ),
          user_id: nil,
          password: nil,
          connection_pool_size: 5,
          connection_pool_ttl: 60,
          min_request_interval: 200
        )
    end
  end
end
