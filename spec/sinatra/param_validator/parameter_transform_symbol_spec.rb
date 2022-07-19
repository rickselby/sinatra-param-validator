# frozen_string_literal: true

require 'sinatra/test_helpers'

describe Sinatra::ParamValidator::Parameter do
  include Sinatra::TestHelpers
  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :identifier do
        param :val, String, transform: :upcase
      end

      post '/', validate: :identifier do
        params.to_json
      end
    end
  end

  it 'can accept a symbol' do
    post '/', { val: 'foo' }
    expect(last_response.body).to eq({ val: 'FOO' }.to_json)
  end
end
