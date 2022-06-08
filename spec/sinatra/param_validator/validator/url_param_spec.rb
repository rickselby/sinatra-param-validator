# frozen_string_literal: true

require 'sinatra/test_helpers'

describe Sinatra::ParamValidator::Validator::UrlParam do
  include Sinatra::TestHelpers
  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :identifier do
        param :number, Integer, required: true
      end

      post '/', validate_url_param: :identifier do
        'OK'.to_json
      end
    end
  end

  it 'returns forbidden for an invalid validation' do
    post '/', {}
    expect(last_response).to be_forbidden
  end
end
