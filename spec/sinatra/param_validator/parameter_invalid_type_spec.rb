# frozen_string_literal: true

require 'sinatra/test_helpers'

# Test that an invalid type raises a type error
describe Sinatra::ParamValidator::Parameter do
  include Sinatra::TestHelpers
  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :identifier do
        param :val, :invalid, required: true
      end

      post '/', validate: :identifier do
        'OK'.to_json
      end
    end
  end

  it 'raises an error for an invalid parameter type' do
    expect { post '/', { val: '10' } }.to raise_error 'Invalid parameter type'
  end
end
