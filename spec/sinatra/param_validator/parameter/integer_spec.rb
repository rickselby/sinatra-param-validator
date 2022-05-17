# frozen_string_literal: true

RSpec.describe Sinatra::ParamValidator::Parameter::Integer do
  subject(:valid) { klass.valid? }

  let(:klass) { described_class.new(value, options) }
  let(:options) { {} }
  let(:value) { '123' }

  describe 'coerce' do
    subject(:coerce) { klass.coerced }

    %w[123 -456].each do |number|
      context "with the string #{number}" do
        let(:value) { number }

        it { is_expected.to eq Integer(number, 10) }
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
    let(:options) { { is: 123 } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { is: 456 } }

      it { is_expected.to be false }
    end
  end

  describe 'in' do
    let(:options) { { in: [123, 456, 789] } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { in: [12, 34, 56] } }

      it { is_expected.to be false }
    end

    context 'with a valid range' do
      let(:options) { { in: 100..200 } }

      it { is_expected.to be true }
    end

    context 'with an invalid range' do
      let(:options) { { in: 200..300 } }

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
      let(:value) { '0' }

      it { is_expected.to be true }
    end
  end

  describe 'max' do
    let(:options) { { max: 200 } }

    it { is_expected.to be true }

    context 'with an invalid maximum' do
      let(:options) { { max: 100 } }

      it { is_expected.to be false }
    end
  end

  describe 'min' do
    let(:options) { { min: 100 } }

    it { is_expected.to be true }

    context 'with an invalid minimum' do
      let(:options) { { min: 200 } }

      it { is_expected.to be false }
    end
  end
end
