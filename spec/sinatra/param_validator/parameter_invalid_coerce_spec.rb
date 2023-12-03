# frozen_string_literal: true

require "sinatra/test_helpers"

# Test that an invalid coercion raises a validation error
describe Sinatra::ParamValidator::Parameter do
  include Sinatra::TestHelpers
  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :identifier do
        param :val, Integer, required: true
      end

      post "/", validate: :identifier do
        "OK".to_json
      end
    end
  end

  it "raises an error for an invalid parameter type" do
    expect { post "/", { val: "foo" } }.to raise_error Sinatra::ParamValidator::ValidationFailedError
  end
end
