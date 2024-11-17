# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::Version do
  subject(:command) { described_class.new }

  include_context('with xtb client stub') do
    let(:request) { JSON.dump(command: :getVersion) }
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
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do
      expect(call)
        .to have_attributes(
          version: '2.4.15'
        )
    end
  end
end
