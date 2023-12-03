# frozen_string_literal: true

require "sinatra/test_helpers"

describe Sinatra::ParamValidator::Rule::OneOf do
  include Sinatra::TestHelpers
  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :identifier do
        rule :one_of, :a, :b
      end

      post "/", validate: :identifier do
        "OK".to_json
      end
    end
  end

  it "passes with one param" do
    post "/", { a: :a }
    expect(last_response).to be_ok
  end

  it "fails with no params" do
    expect { post "/" }.to raise_error Sinatra::ParamValidator::ValidationFailedError
  end

  it "fails with both params" do
    expect { post "/", { a: :a, b: :b } }.to raise_error Sinatra::ParamValidator::ValidationFailedError
  end
end
