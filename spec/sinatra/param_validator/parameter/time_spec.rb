# frozen_string_literal: true

require_relative 'shared_examples'

RSpec.describe Sinatra::ParamValidator::Parameter::Time do
  subject(:valid) { klass.valid? }

  let(:klass) { described_class.new(value, **options) }
  let(:options) { {} }
  let(:value) { Time.new(2022, 5, 17, 11, 30).to_s }

  describe 'coerce' do
    subject(:coerce) { klass.coerced }

    ['2022-05-17 11:30', '202205171130', '17th May 2022 11:30', '17-05-2022 11:30'].each do |time|
      context "with the string #{time}" do
        let(:value) { time }

        it { is_expected.to eq Time.new(2022, 5, 17, 11, 30) }
      end
    end

    %w[foo].each do |string|
      context "with the string #{string}" do
        let(:value) { string }

        it { is_expected.to be_nil }
        example { expect(klass.errors).not_to be_empty }
      end
    end

    it_behaves_like 'it coerces nil to nil'
  end

  describe 'is' do
    let(:options) { { is: Time.new(2022, 5, 17, 11, 30) } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { is: Time.new(2022, 5, 17, 13, 25) } }

      it { is_expected.to be false }
    end

    it_behaves_like 'it handles nil and nillable'
  end

  describe 'in (array)' do
    let(:options) { { in: [Time.new(2022, 5, 17, 11, 30), Time.new(2022, 5, 17, 12, 30)] } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { in: [Time.new(2022, 5, 15), Time.new(2022, 5, 16)] } }

      it { is_expected.to be false }
    end

    it_behaves_like 'it handles nil and nillable'
  end

  describe 'in (range)' do
    let(:options) { { in: Time.new(2022, 5, 1)..Time.new(2022, 6, 1) } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { in: Time.new(2022, 6, 1)..Time.new(2022, 7, 1) } }

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
  end

  describe 'max' do
    let(:options) { { max: Time.new(2022, 6, 1) } }

    it { is_expected.to be true }

    context 'with an invalid maximum' do
      let(:options) { { max: Time.new(2022, 5, 1) } }

      it { is_expected.to be false }
    end

    it_behaves_like 'it handles nil and nillable'
  end

  describe 'min' do
    let(:options) { { min: Time.new(2022, 5, 1) } }

    it { is_expected.to be true }

    context 'with an invalid minimum' do
      let(:options) { { min: Time.new(2022, 6, 1) } }

      it { is_expected.to be false }
    end

    it_behaves_like 'it handles nil and nillable'
  end
end
