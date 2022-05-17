# frozen_string_literal: true

require 'sinatra/test_helpers'

describe Sinatra::ParamValidator do
  include Sinatra::TestHelpers
  before do
    klass = described_class
    mock_app do
      register klass

      validator :identifier do
        param :number, Integer, required: true
      end

      post '/', validate: :identifier do
        'OK'.to_json
      end
    end
  end

  it 'returns OK for valid numbers' do
    post '/', { number: '10' }
    expect(last_response).to be_ok
  end

  it 'returns bad request for an invalid validation' do
    expect { post '/', {} }.to raise_error 'Validation Failed'
  end
end
