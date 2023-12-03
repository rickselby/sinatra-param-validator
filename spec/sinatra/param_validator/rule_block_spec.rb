# frozen_string_literal: true

require "sinatra/test_helpers"

# Test that a custom message gets passed through to the exception
describe Sinatra::ParamValidator::Rule do
  include Sinatra::TestHelpers
  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :identifier do
        rule :any_of, :a, :b do
          raise "This block has been called"
        end
      end

      post "/", validate: :identifier do
        # ...
      end
    end
  end

  it "runs the code in the block if the validator passes" do
    expect { post "/", { a: 20 } }.to raise_error "This block has been called"
  end

  it "does not run the code in the block if the validator fails" do
    expect { post "/", { c: "foo" } }.to raise_error Sinatra::ParamValidator::ValidationFailedError
  end
end
