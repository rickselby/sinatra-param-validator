# frozen_string_literal: true

RSpec.describe Sinatra::ParamValidator::Parameter::String do
  subject(:valid) { klass.valid? }

  let(:klass) { described_class.new(value, options) }
  let(:options) { {} }
  let(:value) { 'string' }

  describe 'coerce' do
    subject(:coerce) { klass.coerce }

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
  end

  describe 'blank' do
    let(:options) { { blank: false } }

    it { is_expected.to be true }

    context 'with a blank value' do
      let(:value) { nil }

      it { is_expected.to be false }
    end
  end

  describe 'format' do
    let(:options) { { format: /str.*/ } }

    it { is_expected.to be true }

    context 'with an invalid format' do
      let(:options) { { format: /foo.*/ } }

      it { is_expected.to be false }
    end
  end

  describe 'is' do
    let(:options) { { is: 'string' } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { is: 'foo' } }

      it { is_expected.to be false }
    end
  end

  describe 'in' do
    let(:options) { { in: %w[string other] } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { in: %w[foo bar] } }

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
      let(:value) { '' }

      it { is_expected.to be true }
    end
  end
end
