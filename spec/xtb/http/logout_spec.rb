# frozen_string_literal: true

require_relative '../../support/shared'

RSpec.describe Xtb::Http::Logout do
  subject(:command) { described_class.new }

  include_context('with xtb client stub') do
    let(:request) { JSON.dump(command: :logout) }
    let(:response) do
      JSON.dump(
        {
          'status': true
        }
      )
    end
  end

  describe '#call' do
    subject(:call) { command.call }

    specify do
      expect(call)
        .to have_attributes(status: true)
    end
  end
end
