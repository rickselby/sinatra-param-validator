# frozen_string_literal: true

require 'sinatra/test_helpers'

describe Sinatra::ParamValidator do
  include Sinatra::TestHelpers
  before do
    klass = described_class
    mock_app do
      register klass

      validator identifier: :identifier do
        param :a, Integer
        param :b, Integer
        param :c, Integer
      end

      post '/', validate: :identifier do
        params.to_json
      end
    end
  end

  it 'does not create params when they are not given' do
    post '/'
    expect(last_response.body).to eq({}.to_json)
  end
end
