RSpec.describe Xtb::Http::Version do
  subject(:command) { described_class.new }

  let(:response) do
    JSON.dump(
      {
        'status': true,
        'returnData': {
          'version': '2.4.15'
        }
      }
    )
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do
      expect(Xtb::Http::SslClient)
        .to receive(:request)
              .with(JSON.dump(command: :getVersion))
              .and_return(response)
      expect(call)
        .to have_attributes(
              version: '2.4.15'
            )
    end
  end
end