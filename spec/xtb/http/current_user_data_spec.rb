# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::CurrentUserData do
  subject(:command) { described_class.new }

  include_context('with xtb client stub') do
    let(:request) { JSON.dump(command: :getCurrentUserData) }
    let(:response) do
      JSON.dump(
        {
          'status': true,
          'return_data': {
            'companyUnit': 8,
            'currency': 'PLN',
            'group': 'demoPLeurSTANDARD200',
            'ibAccount': false,
            'leverage': 1,
            'leverageMultiplier': 0.25,
            'spreadType': 'FLOAT',
            'trailingStop': false
          }
        }
      )
    end
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do # rubocop:disable RSpec/ExampleLength
      expect(call)
        .to have_attributes(
          company_unit: 8,
          currency: 'PLN',
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
