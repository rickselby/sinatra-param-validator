# frozen_string_literal: true

require 'sinatra/test_helpers'

# Test that an invalid coercion raises a validation error
describe Sinatra::ParamValidator do
  include Sinatra::TestHelpers
  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :set_foo do
        @foo = 'foo'
      end

      validator :set_bar do
        @bar = @foo
      end

      post '/', validate: %i[set_foo set_bar] do
        @bar
      end
    end
  end

  it 'can set an instance variable to be used elsewhere' do
    expect(post('/').body).to eq 'foo'
  end
end
