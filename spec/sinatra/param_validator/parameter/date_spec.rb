# frozen_string_literal: true

require_relative "shared_examples"

RSpec.describe Sinatra::ParamValidator::Parameter::Date do
  subject(:valid) { klass.valid? }

  let(:klass)   { described_class.new(value, **options) }
  let(:options) { {}                                    }
  let(:value)   { Date.new(2022, 5, 17).to_s            }

  describe "coerce" do
    subject(:coerce) { klass.coerced }

    ["2022-05-17", "20220517", "17th May 2022", "17-05-2022"].each do |date|
      context "with the string #{date}" do
        let(:value) { date }

        it { is_expected.to eq Date.new(2022, 5, 17) }
      end
    end

    # Check that previously coerced values do not fail if revalidated
    context "with a date" do
      let(:value) { Date.new(2022, 5, 17) }

      it { is_expected.to eq value }
    end

    %w[foo].each do |string|
      context "with the string #{string}" do
        let(:value) { string }

        it { is_expected.to be_nil }
        example { expect(klass.errors).not_to be_empty }
      end
    end

    it_behaves_like "it coerces nil to nil"
  end

  describe "is" do
    let(:options) { { is: Date.new(2022, 5, 17) } }

    it { is_expected.to be true }

    context "with an invalid option" do
      let(:options) { { is: Date.new(2022, 5, 15) } }

      it { is_expected.to be false }
    end

    it_behaves_like "it handles nil and nillable"
  end

  describe "in (array)" do
    let(:options) { { in: [Date.new(2022, 5, 17), Date.new(2022, 5, 18)] } }

    it { is_expected.to be true }

    context "with an invalid option" do
      let(:options) { { in: [Date.new(2022, 5, 15), Date.new(2022, 5, 16)] } }

      it { is_expected.to be false }
    end

    it_behaves_like "it handles nil and nillable"
  end

  describe "in (range)" do
    let(:options) { { in: Date.new(2022, 5, 1)..Date.new(2022, 6, 1) } }

    it { is_expected.to be true }

    context "with an invalid option" do
      let(:options) { { in: Date.new(2022, 6, 1)..Date.new(2022, 7, 1) } }

      it { is_expected.to be false }
    end

    it_behaves_like "it handles nil and nillable"
  end

  describe "required" do
    let(:options) { { required: true } }

    it { is_expected.to be true }

    context "without a value" do
      let(:value) { nil }

      it { is_expected.to be false }
    end
  end

  describe "max" do
    let(:options) { { max: Date.new(2022, 6, 1) } }

    it { is_expected.to be true }

    context "with an invalid maximum" do
      let(:options) { { max: Date.new(2022, 5, 1) } }

      it { is_expected.to be false }
    end

    it_behaves_like "it handles nil and nillable"
  end

  describe "min" do
    let(:options) { { min: Date.new(2022, 5, 1) } }

    it { is_expected.to be true }

    context "with an invalid minimum" do
      let(:options) { { min: Date.new(2022, 6, 1) } }

      it { is_expected.to be false }
    end

    it_behaves_like "it handles nil and nillable"
  end
end
