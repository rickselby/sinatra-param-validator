# frozen_string_literal: true

require 'sinatra/test_helpers'

describe Sinatra::ParamValidator::Parameter do
  include Sinatra::TestHelpers
  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :identifier do
        param :time, Time, default: -> { '12:59' }, transform: ->(v) { v.strftime('%H:%M') }
      end

      post '/', validate: :identifier do
        params.to_json
      end
    end
  end

  it 'does not transform the default value' do
    post '/', { time: nil }
    expect(last_response.body).to eq({ time: '12:59' }.to_json)
  end
end
