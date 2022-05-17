# frozen_string_literal: true

RSpec.describe Sinatra::ParamValidator::Parameter::Float do
  subject(:valid) { klass.valid? }

  let(:klass) { described_class.new(value, options) }
  let(:options) { {} }
  let(:value) { 12.34 }

  describe 'coerce' do
    subject(:coerce) { klass.coerce }

    %w[123 -456 78.9].each do |number|
      context "with the string #{number}" do
        let(:value) { number }

        it { is_expected.to eq Float(number) }
      end
    end

    %w[foo f123].each do |string|
      context "with the string #{string}" do
        let(:value) { string }

        example { expect { coerce }.to raise_error ArgumentError }
      end
    end
  end

  describe 'is' do
    let(:options) { { is: 12.34 } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { is: 1.23 } }

      it { is_expected.to be false }
    end
  end

  describe 'in' do
    let(:options) { { in: [12.34, 56.78] } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { in: [12, 34, 56] } }

      it { is_expected.to be false }
    end

    context 'with a valid range' do
      let(:options) { { in: 10..20 } }

      it { is_expected.to be true }
    end

    context 'with an invalid range' do
      let(:options) { { in: 20..30 } }

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

    context 'with zero' do
      let(:value) { 0.0 }

      it { is_expected.to be true }
    end
  end

  describe 'max' do
    let(:options) { { max: 20 } }

    it { is_expected.to be true }

    context 'with an invalid maximum' do
      let(:options) { { max: 10 } }

      it { is_expected.to be false }
    end
  end

  describe 'min' do
    let(:options) { { min: 10 } }

    it { is_expected.to be true }

    context 'with an invalid minimum' do
      let(:options) { { min: 20 } }

      it { is_expected.to be false }
    end
  end
end
