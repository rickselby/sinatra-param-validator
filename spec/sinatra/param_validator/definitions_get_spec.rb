# frozen_string_literal: true

describe Sinatra::ParamValidator::Definitions, ".get" do
  let(:definitions) { described_class.new }

  it "can get a predefined definition" do
    definitions.add :foo, :bar
    expect { definitions.get :foo }.not_to raise_error
  end

  it "does not allow an undefined validator to be retrieved" do
    expect { definitions.get :foo }.to raise_error "Unknown validator: 'foo'"
  end
end
