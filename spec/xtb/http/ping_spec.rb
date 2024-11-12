# frozen_string_literal: true

RSpec.describe Xtb::Http::Ping do
  subject(:command) { described_class.new }

  let(:response) do
    JSON.dump(
      {
        'status': true
      }
    )
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do
      expect(Xtb::Http::SslClient)
        .to receive(:request)
        .with(JSON.dump(command: :ping))
        .and_return(response)
      expect(call)
        .to have_attributes(status: true)
    end
  end
end
