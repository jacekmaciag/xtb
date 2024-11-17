# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::StepRules do
  subject(:command) { described_class.new }

  include_context('with xtb client stub') do
    let(:request) { JSON.dump(command: :getStepRules) }
    let(:response) do
      JSON.dump(
        {
          'status': true,
          'return_data': [
            {
              'fromValue': 0.1,
              'step': 0.0025
            }
          ]
        }
      )
    end
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do
      expect(call.first)
        .to have_attributes(
          from_value: 0.1,
          step: 0.0025
        )
    end
  end
end
