# frozen_string_literal: true

require 'sinatra/test_helpers'

# Test we can use a coerced parameter in a later validation
describe Sinatra::ParamValidator do
  include Sinatra::TestHelpers
  before do
    klass = described_class
    mock_app do
      register klass

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
        'OK'.to_json
      end
    end
  end

  it 'returns OK for no fields' do
    post '/'
    expect(last_response).to be_ok
  end

  it 'returns OK for empty fields' do
    post '/', { array: '', bool: '', date: '', float: '', hash: '', integer: '', string: '', time: '' }
    expect(last_response).to be_ok
  end
end
