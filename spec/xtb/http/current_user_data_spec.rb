# frozen_string_literal: true

RSpec.describe Xtb::Http::CurrentUserData do
  subject(:command) { described_class.new }

  let(:response) do
    JSON.dump({
                'status' => true,
                'return_data' => {
                  'companyUnit' => 1,
                  'currency' => 'USD',
                  'group' => 'demoPLeurSTANDARD200',
                  'ibAccount' => false,
                  'leverage' => 1,
                  'leverageMultiplier' => 0.25,
                  'spreadType' => 'FLOAT',
                  'trailingStop' => false
                }
              })
  end

  describe '#call' do
    before do
      allow(Xtb::Http::SslClient).to receive(:request).and_return(response)
    end

    specify do
      expect(command.call).to have_attributes(
        company_unit: 1,
        currency: 'USD',
        group: 'demoPLeurSTANDARD200',
        ib_account: false,
        leverage: 1,
        leverage_multiplier: 0.25,
        spread_type: 'FLOAT',
        trailing_stop: false
      )
    end
  end
end
