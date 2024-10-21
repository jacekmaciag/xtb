# frozen_string_literal: true

RSpec.describe Xtb::Http::StepRules do
  subject(:command) { described_class.new }

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

  describe '#call' do
    subject(:call) { command.call }

    specify do
      expect(Xtb::Http::SslClient)
        .to receive(:request)
        .with(JSON.dump(command: :getStepRules))
        .and_return(response)
      expect(call.first)
        .to have_attributes(
          from_value: 0.1,
          step: 0.0025
        )
    end
  end
end
