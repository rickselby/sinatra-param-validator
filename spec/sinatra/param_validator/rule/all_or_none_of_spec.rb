# frozen_string_literal: true

RSpec.describe Sinatra::ParamValidator::Rule::AllOrNoneOf do
  subject(:passes) { klass.passes? }

  let(:fields) { %i[a b] }
  let(:klass) { described_class.new(params, *fields) }
  let(:params) { { a: :a, b: :b, c: :c } }

  context "with all fields defined" do
    it { is_expected.to be true }
  end

  context "with one field defined" do
    let(:params) { { a: :a, c: :c } }

    it { is_expected.to be false }
  end

  context "with no fields defined" do
    let(:params) { { c: :c } }

    it { is_expected.to be true }
  end
end
