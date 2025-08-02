# frozen_string_literal: true

require "sinatra/test_helpers"

describe Sinatra::ParamValidator::Validator::Form do
  include Sinatra::TestHelpers

  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :identifier do
        param :number, Integer, required: true
      end

      post "/", validate_form: :identifier do
        "OK".to_json
      end
    end
  end

  it "returns bad request for an invalid validation" do
    post "/", {}
    expect(last_response).to be_bad_request
  end

  context "with an xhr request" do
    before { env "HTTP_ACCEPT", "application/json, */*;q=0.8" }

    it "returns bad request for an invalid validation" do
      post "/", {}
      expect(last_response).to be_bad_request
    end

    it "returns a json object with validation details" do
      post "/", {}
      expected_response = { error: "Validation failed", fields: { number: ["Parameter is required"] } }.to_json
      expect(last_response.body).to eq expected_response
    end
  end
end
