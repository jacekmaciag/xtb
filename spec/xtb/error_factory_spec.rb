# frozen_string_literal: true

require_relative '../../lib/xtb/error'
require_relative '../../lib/xtb/error_factory'

RSpec.describe Xtb::ErrorFactory do
  subject(:error_factory) { described_class }

  describe '.create' do
    subject(:create) { error_factory.create(error_code, error_description) }

    let(:error_code) { 'BE004' }
    let(:error_description) { '' }

    specify 'it correctly maps error code to the error' do
      expect(create)
        .to be_a(Xtb::LoginDisabledError)
        .and have_attributes(message: '(BE004) Login disabled')
    end

    context 'when error code is unknown' do
      let(:error_code) { 'XY123' }
      let(:error_description) { 'This is an unknown issue' }

      specify 'it correctly maps error code to the error' do
        expect(create)
          .to be_a(Xtb::Error)
          .and have_attributes(message: '(XY123) This is an unknown issue')
      end
    end

    context 'when error code points to a duplicate code' do
      let(:error_code) { 'BE116' }

      specify 'it correctly maps duplicated error code to the error' do
        expect(create)
          .to be_a(Xtb::SymbolDoesNotExistError)
          .and have_attributes(message: '(BE116) Symbol does not exist')
      end
    end

    context 'when error code matches SExxx' do
      let(:error_code) { 'SE123' }

      specify 'it correctly maps duplicated error code to the error' do
        expect(create)
          .to be_a(Xtb::InternalError)
          .and have_attributes(message: '(SE123) Internal error, in case of such error, please contact support')
      end
    end
  end
end
