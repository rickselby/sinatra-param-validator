# frozen_string_literal: true

require 'sinatra/test_helpers'

# Test we can use validations within blocks
describe Sinatra::ParamValidator do
  include Sinatra::TestHelpers
  before do
    klass = described_class
    mock_app do
      register klass

      validator :identifier do
        param :max, Integer, required: true do |v|
          v.param :value, Integer, required: true, max: params[:max]
        end
      end

      post '/', validate: :identifier do
        'OK'.to_json
      end
    end
  end

  it 'returns OK for valid numbers' do
    post '/', { max: '10', value: '5' }
    expect(last_response).to be_ok
  end

  it 'raises an error for invalid numbers' do
    expect { post '/', { max: '10', value: '15' } }.to raise_error Sinatra::ParamValidator::ValidationFailedError
  end
end
