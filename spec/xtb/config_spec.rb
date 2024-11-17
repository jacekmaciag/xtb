# frozen_string_literal: true

RSpec.describe Xtb::Config do
  subject(:config) { described_class }

  describe '.https_host' do
    before { ENV['XTB__HTTPS_HOST'] = nil }

    it 'returns the default value' do
      expect(config.https_host).to eq('xapi.xtb.com')
    end

    context 'when the environment variable is set' do
      before { ENV['XTB__HTTPS_HOST'] = 'example.com' }

      it 'returns the environment variable value' do
        expect(config.https_host).to eq('example.com')
      end
    end
  end

  describe '.https_port' do
    before { ENV['XTB__HTTPS_PORT'] = nil }

    it 'returns the default value' do
      expect(config.https_port).to eq(5124)
    end

    context 'when the environment variable is set' do
      before { ENV['XTB__HTTPS_PORT'] = '1234' }

      it 'returns the environment variable value' do
        expect(config.https_port).to eq(1234)
      end
    end
  end

  describe '.wss_host' do
    before { ENV['XTB__WSS_HOST'] = nil }

    it 'returns the default value' do
      expect(config.wss_host).to eq('ws.xtb.com')
    end

    context 'when the environment variable is set' do
      before { ENV['XTB__WSS_HOST'] = 'example.com' }

      it 'returns the environment variable value' do
        expect(config.wss_host).to eq('example.com')
      end
    end
  end

  describe '.wss_path' do
    before { ENV['XTB__WSS_PATH'] = nil }

    it 'returns the default value' do
      expect(config.wss_path).to eq('demo')
    end

    context 'when the environment variable is set' do
      before { ENV['XTB__WSS_PATH'] = 'example' }

      it 'returns the environment variable value' do
        expect(config.wss_path).to eq('example')
      end
    end
  end

  describe '.wss_port' do
    before { ENV['XTB__WSS_PORT'] = nil }

    it 'returns the default value' do
      expect(config.wss_port).to eq(5125)
    end

    context 'when the environment variable is set' do
      before { ENV['XTB__WSS_PORT'] = '1234' }

      it 'returns the environment variable value' do
        expect(config.wss_port).to eq(1234)
      end
    end
  end

  describe '.user_id' do
    before { ENV['XTB__USER_ID'] = nil }

    it 'raises an error' do
      expect { config.user_id }.to raise_error('XTB__USER_ID is required')
    end

    context 'when the environment variable is set' do
      before { ENV['XTB__USER_ID'] = 'user1234' }

      it 'returns the environment variable value' do
        expect(config.user_id).to eq('user1234')
      end
    end
  end

  describe '.password' do
    before { ENV['XTB__PASSWORD'] = nil }

    it 'raises an error' do
      expect { config.password }.to raise_error('XTB__PASSWORD is required')
    end

    context 'when the environment variable is set' do
      before { ENV['XTB__PASSWORD'] = 'pass1234' }

      it 'returns the environment variable value' do
        expect(config.password).to eq('pass1234')
      end
    end
  end

  describe '.connection_pool_size' do
    before { ENV['XTB__CONNECTION_POOL_SIZE'] = nil }

    it 'returns the default value' do
      expect(config.connection_pool_size).to eq(5)
    end

    context 'when the environment variable is set' do
      before { ENV['XTB__CONNECTION_POOL_SIZE'] = '49' }

      it 'returns the environment variable value' do
        expect(config.connection_pool_size).to eq(49)
      end

      context 'when the request interval is less than the default value' do
        before { ENV['XTB__CONNECTION_POOL_SIZE'] = '51' }

        it 'raises an error' do
          expect { config.connection_pool_size }
            .to raise_error('Max connection pool size is 50')
        end
      end
    end
  end

  describe '.min_request_interval' do
    before { ENV['XTB__MIN_REQUEST_INTERVAL'] = nil }

    it 'returns the default value' do
      expect(config.min_request_interval).to eq(200)
    end

    context 'when the environment variable is set' do
      before { ENV['XTB__MIN_REQUEST_INTERVAL'] = '201' }

      it 'returns the environment variable value' do
        expect(config.min_request_interval).to eq(201)
      end

      context 'when the request interval is less than the default value' do
        before { ENV['XTB__MIN_REQUEST_INTERVAL'] = '199' }

        it 'raises an error' do
          expect { config.min_request_interval }
            .to raise_error('Minimum request interval must be greater than or equal to 200')
        end
      end
    end
  end
end
