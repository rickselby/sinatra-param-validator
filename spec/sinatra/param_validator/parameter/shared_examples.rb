# frozen_string_literal: true

RSpec.shared_examples "it coerces nil to nil" do
  let(:value) { nil }

  it { is_expected.to be_nil }
end

RSpec.shared_examples "it handles nil and nillable" do
  let(:value) { nil }

  it { is_expected.to be false }

  context "when nillable" do
    let(:options) { super().merge({ nillable: true }) }

    it { is_expected.to be true }
  end
end
