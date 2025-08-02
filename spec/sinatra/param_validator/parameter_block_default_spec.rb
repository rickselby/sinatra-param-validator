# frozen_string_literal: true

require "sinatra/test_helpers"

# Test that a custom message gets passed through to the exception
describe Sinatra::ParamValidator::Parameter do
  include Sinatra::TestHelpers

  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :identifier do
        param :val, Integer, default: 12 do
          raise "Value is #{params[:val]}"
        end
      end

      post "/", validate: :identifier do
        # ...
      end
    end
  end

  it "runs the code in the block if the validator passes" do
    expect { post "/", { val: 20 } }.to raise_error "Value is 20"
  end

  it "does not run the code in the block if the validator fails" do
    expect { post "/", { val: "foo" } }.to raise_error Sinatra::ParamValidator::ValidationFailedError
  end

  it "runs the code in the block even if the parameter was not provided" do
    expect { post "/" }.to raise_error "Value is 12"
  end
end
