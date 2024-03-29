# frozen_string_literal: true

require "sinatra/test_helpers"

# Test the use of the route condition 'validate' to run a validator
describe Sinatra::ParamValidator do
  include Sinatra::TestHelpers
  before do
    klass = described_class
    mock_app do
      register klass

      validator :identifier do
        param :number, Integer, required: true
      end

      post "/", validate: :identifier do
        "OK".to_json
      end
    end
  end

  it "returns OK for valid numbers" do
    post "/", { number: "10" }
    expect(last_response).to be_ok
  end

  it "raises an error for an invalid validation" do
    expect { post "/", {} }.to raise_error Sinatra::ParamValidator::ValidationFailedError
  end
end
