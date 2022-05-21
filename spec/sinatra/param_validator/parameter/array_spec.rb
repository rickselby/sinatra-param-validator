# frozen_string_literal: true

require_relative 'shared_examples'

RSpec.describe Sinatra::ParamValidator::Parameter::Array do
  subject(:valid) { klass.valid? }

  let(:klass) { described_class.new(value, **options) }
  let(:options) { {} }
  let(:value) { %w[a b c] }

  describe 'coerce' do
    subject(:coerce) { klass.coerced }

    %w[a,b,c d e,f].each do |string|
      context "with the string #{string}" do
        let(:value) { string }

        it { is_expected.to eq string.split ',' }
      end
    end

    [%i[a b], [:c], []].each do |array|
      context "with the array #{array}" do
        let(:value) { array }

        it { is_expected.to eq array }
      end
    end

    it_behaves_like 'it coerces nil to nil'
  end

  describe 'is' do
    let(:options) { { is: %w[a b c] } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { is: %w[a b] } }

      it { is_expected.to be false }
    end

    it_behaves_like 'it handles nil and nillable'
  end

  describe 'in' do
    let(:options) { { in: [%w[a b c], %w[d e]] } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { in: [%w[a b], %w[d e]] } }

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
      let(:value) { [] }

      it { is_expected.to be true }
    end
  end

  describe 'max_length' do
    let(:options) { { max_length: 5 } }

    it { is_expected.to be true }

    context 'with an invalid maximum' do
      let(:options) { { max_length: 2 } }

      it { is_expected.to be false }
    end

    it_behaves_like 'it handles nil and nillable'
  end

  describe 'min_length' do
    let(:options) { { min_length: 2 } }

    it { is_expected.to be true }

    context 'with an invalid minimum' do
      let(:options) { { min_length: 5 } }

      it { is_expected.to be false }
    end

    it_behaves_like 'it handles nil and nillable'
  end
end
