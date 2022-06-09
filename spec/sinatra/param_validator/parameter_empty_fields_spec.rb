# frozen_string_literal: true

require 'sinatra/test_helpers'

describe Sinatra::ParamValidator::Parameter do
  include Sinatra::TestHelpers
  before do
    mock_app do
      register Sinatra::ParamValidator

      validator :identifier do
        param :array, Array
        param :bool, :boolean
        param :date, Date
        param :float, Float
        param :hash, Hash
        param :integer, Integer
        param :string, String
        param :time, Time
      end

      post '/', validate: :identifier do
        params.to_json
      end
    end
  end

  it 'returns OK for no fields' do
    post '/'
    expect(last_response).to be_ok
  end

  it 'does not create params when they are not given' do
    post '/'
    expect(last_response.body).to eq({}.to_json)
  end

  it 'returns OK for empty fields' do
    post '/', { array: '', bool: '', date: '', float: '', hash: '', integer: '', string: '', time: '' }
    expect(last_response).to be_ok
  end
end
