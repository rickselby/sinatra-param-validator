# frozen_string_literal: true

require 'sinatra/test_helpers'

# Test that an invalid coercion raises a type error
describe Sinatra::ParamValidator do
  include Sinatra::TestHelpers
  before do
    klass = described_class
    mock_app do
      register klass

      validator identifier: :identifier do
        param :max, :invalid, required: true
      end

      post '/', validate: :identifier do
        'OK'.to_json
      end
    end
  end

  it 'raises an error for an invalid parameter type' do
    expect { post '/', { max: '10' } }.to raise_error 'Invalid parameter type'
  end
end
