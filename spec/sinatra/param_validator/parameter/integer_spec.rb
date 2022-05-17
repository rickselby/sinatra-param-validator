# frozen_string_literal: true

RSpec.describe Sinatra::ParamValidator::Parameter::Integer do
  subject(:valid) { klass.valid? }

  let(:klass) { described_class.new(value, options) }
  let(:options) { {} }
  let(:value) { 123 }

  describe 'coerce' do
    subject(:coerce) { klass.coerce }

    %w[123 -456].each do |number|
      context "with the string #{number}" do
        let(:value) { number }

        it { is_expected.to eq Integer(number, 10) }
      end
    end

    [true, false].each do |bool|
      context "with the bool #{bool}" do
        let(:value) { bool }

        it { expect { coerce }.to raise_error ArgumentError }
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
      let(:value) { 0 }

      it { is_expected.to be true }
    end
  end
end
