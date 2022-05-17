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
          param :string, String, required: true, blank: false
        end
        validate validator, {}
        'OK'.to_json
      end
    end
  end

  it 'returns OK for a valid validation' do
    post '/', { string: 'foo' }
    expect(last_response).to be_ok
  end

  it 'returns bad request for an invalid validation' do
    expect { post '/', {} }.to raise_error 'Validation Failed'
  end
end
