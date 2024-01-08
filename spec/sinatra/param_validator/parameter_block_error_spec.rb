# frozen_string_literal: true

require "sinatra/test_helpers"

# Test that a custom message gets passed through to the exception
describe Sinatra::ParamValidator::Parameter do
  include Sinatra::TestHelpers
  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :identifier do
        param :val, Integer, message: "The validation failed" do
          raise Sinatra::ParamValidator::InvalidParameterError, "This was raised"
        end
      end

      post "/", validate: :identifier do
        # ...
      end
    end
  end

  it "runs the code in the block if the validator passes" do
    expect { post "/", { val: 20 } }.to raise_error(
      an_instance_of(Sinatra::ParamValidator::ValidationFailedError).and(
        having_attributes(errors: { val: ["This was raised"] }),
      ),
    )
  end

  it "does not run the code in the block if the validator fails" do
    expect { post "/", { val: "foo" } }.to raise_error(
      an_instance_of(Sinatra::ParamValidator::ValidationFailedError).and(
        having_attributes(errors: { val: ["The validation failed"] }),
      ),
    )
  end
end
