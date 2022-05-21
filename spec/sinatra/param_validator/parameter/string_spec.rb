# frozen_string_literal: true

require_relative 'shared_examples'

RSpec.describe Sinatra::ParamValidator::Parameter::String do
  subject(:valid) { klass.valid? }

  let(:klass) { described_class.new(value, **options) }
  let(:options) { {} }
  let(:value) { 'string' }

  describe 'coerce' do
    subject(:coerce) { klass.coerced }

    [123, -456, 78.9].each do |number|
      context "with the number #{number}" do
        let(:value) { number }

        it { is_expected.to eq number.to_s }
      end
    end

    [true, false].each do |bool|
      context "with the bool #{bool}" do
        let(:value) { bool }

        it { is_expected.to eq bool.to_s }
      end
    end

    it_behaves_like 'it coerces nil to nil'
  end

  describe 'blank' do
    let(:options) { { blank: false } }

    it { is_expected.to be true }

    context 'with a blank value' do
      let(:value) { nil }

      it { is_expected.to be false }
    end

    it_behaves_like 'it handles nil and nillable'
  end

  describe 'format' do
    let(:options) { { format: /str.*/ } }

    it { is_expected.to be true }

    context 'with an invalid format' do
      let(:options) { { format: /foo.*/ } }

      it { is_expected.to be false }
    end

    it_behaves_like 'it handles nil and nillable'
  end

  describe 'is' do
    let(:options) { { is: 'string' } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { is: 'foo' } }

      it { is_expected.to be false }
    end

    it_behaves_like 'it handles nil and nillable'
  end

  describe 'in' do
    let(:options) { { in: %w[string other] } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { in: %w[foo bar] } }

      it { is_expected.to be false }
    end

    it_behaves_like 'it handles nil and nillable'
  end

  describe 'required' do
    let(:options) { { required: true } }

    it { is_expected.to be true }

    context 'without a value' do
      let(:value) { nil }

      it { is_expected.to be false }
    end

    context 'with an empty value' do
      let(:value) { '' }

      it { is_expected.to be true }
    end
  end

  describe 'max_length' do
    let(:options) { { max_length: 10 } }

    it { is_expected.to be true }

    context 'with an invalid maximum' do
      let(:options) { { max_length: 5 } }

      it { is_expected.to be false }
    end

    it_behaves_like 'it handles nil and nillable'
  end

  describe 'min_length' do
    let(:options) { { min_length: 5 } }

    it { is_expected.to be true }

    context 'with an invalid maximum' do
      let(:options) { { min_length: 10 } }

      it { is_expected.to be false }
    end

    it_behaves_like 'it handles nil and nillable'
  end
end
