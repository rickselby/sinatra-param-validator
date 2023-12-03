# frozen_string_literal: true

require "sinatra/test_helpers"

# Test that an invalid coercion raises a validation error
describe Sinatra::ParamValidator::Parameter do
  include Sinatra::TestHelpers
  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :identifier do
        param :flag, :boolean
      end

      post "/", validate: :identifier do
        params.to_json
      end
    end
  end

  it "coerces true successfully" do
    expect(post("/", { flag: "true" }).body).to eq({ flag: true }.to_json)
  end

  it "coerces false successfully" do
    expect(post("/", { flag: "false" }).body).to eq({ flag: false }.to_json)
  end
end
