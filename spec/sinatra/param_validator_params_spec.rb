# frozen_string_literal: true

require "sinatra/test_helpers"

# Test the use of params later in the validator block
describe Sinatra::ParamValidator do
  include Sinatra::TestHelpers

  before do
    klass = described_class
    mock_app do
      register klass

      validator :identifier do
        param :max, Integer, required: true
        param :number, Integer, required: true, max: params[:max]
      end

      post "/", validate: :identifier do
        "OK".to_json
      end
    end
  end

  it "returns OK for valid numbers" do
    post "/", { number: "10", max: "15" }
    expect(last_response).to be_ok
  end

  it "raises an error for an invalid validation" do
    expect { post "/", { number: "10", max: "5" } }.to raise_error Sinatra::ParamValidator::ValidationFailedError
  end
end
