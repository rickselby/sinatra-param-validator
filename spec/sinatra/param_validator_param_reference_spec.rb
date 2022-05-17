# frozen_string_literal: true

require 'sinatra/test_helpers'

describe Sinatra::ParamValidator do
  include Sinatra::TestHelpers
  before do
    klass = described_class
    mock_app do
      helpers Sinatra::ParamValidator::Helpers

      post '/' do
        validator = klass.define :identifier do
          param :max, Integer, required: true
          param :value, Integer, required: true, max: params[:max]
        end
        validate validator, {}
        'OK'.to_json
      end
    end
  end

  it 'returns OK for valid numbers' do
    post '/', { max: '10', value: '5' }
    expect(last_response).to be_ok
  end

  it 'returns bad request for invalid numbers' do
    expect { post '/', { max: '10', value: '15' } }.to raise_error 'Validation Failed'
  end
end
