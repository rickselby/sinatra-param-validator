# frozen_string_literal: true

require "sinatra/test_helpers"

# Test that instance variables can be passed around
# rubocop:disable RSpec/InstanceVariable
describe Sinatra::ParamValidator do
  include Sinatra::TestHelpers

  before do
    klass = described_class
    mock_app do
      register klass

      validator :set_foo do
        @foo = "foo"
      end

      validator :set_bar do
        @bar = @foo
      end

      post "/", validate: %i[set_foo set_bar] do
        @bar
      end
    end
  end

  it "can set an instance variable to be used elsewhere" do
    expect(post("/").body).to eq "foo"
  end
end
# rubocop:enable RSpec/InstanceVariable
