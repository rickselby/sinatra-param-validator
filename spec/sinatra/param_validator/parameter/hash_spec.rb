# frozen_string_literal: true

RSpec.describe Sinatra::ParamValidator::Parameter::Hash do
  subject(:valid) { klass.valid? }

  let(:klass) { described_class.new(value, **options) }
  let(:options) { {} }
  let(:value) { { a: 1, b: 2, c: 3 } }

  describe 'coerce' do
    subject(:coerce) { klass.coerced }

    context 'with a string' do
      let(:value) { 'a:1,b:2' }

      it { is_expected.to eq({ 'a' => '1', 'b' => '2' }) }
    end

    [{ a: 1, b: 2 }, { c: :foo }].each do |hash|
      context "with the array #{hash}" do
        let(:value) { hash }

        it { is_expected.to eq(hash) }
      end
    end
  end

  describe 'is' do
    let(:options) { { is: value } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { is: { a: 1, b: 3 } } }

      it { is_expected.to be false }
    end
  end

  describe 'in' do
    let(:options) { { in: [value] } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { in: [{ a: 1, b: 3 }] } }

      it { is_expected.to be false }
    end
  end

  describe 'required' do
    let(:options) { { required: true } }

    it { is_expected.to be true }

    context 'without a value' do
      let(:value) { nil }

      it { is_expected.to be false }
    end

    context 'with an empty value' do
      let(:value) { {} }

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
  end

  describe 'min_length' do
    let(:options) { { min_length: 2 } }

    it { is_expected.to be true }

    context 'with an invalid maximum' do
      let(:options) { { min_length: 5 } }

      it { is_expected.to be false }
    end
  end
end
