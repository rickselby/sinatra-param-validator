# frozen_string_literal: true

require 'sinatra/test_helpers'

describe Sinatra::ParamValidator::Parameter do
  include Sinatra::TestHelpers
  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :identifier do
        param :val, Integer, default: 40
      end

      post '/', validate: :identifier do
        params.to_json
      end
    end
  end

  it 'does not change the value if one is passed' do
    post '/', { val: 10 }
    expect(last_response.body).to eq({ val: 10 }.to_json)
  end

  it 'does change the value if nothing is passed' do
    post '/'
    expect(last_response.body).to eq({ val: 40 }.to_json)
  end
end
