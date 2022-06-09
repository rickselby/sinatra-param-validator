# frozen_string_literal: true

require 'sinatra/test_helpers'

# Test that a custom message gets passed through to the exception
describe Sinatra::ParamValidator do
  include Sinatra::TestHelpers
  before do
    klass = described_class
    local_min = min
    mock_app do
      register klass

      validator :identifier do |x|
        param :val, Integer, min: x
      end

      post '/', validate: vi(:identifier, local_min) do
        'OK'.to_json
      end
    end
  end

  let(:min) { 10 }

  it 'passes arguments to the validator' do
    post '/', { val: 20 }
    expect(last_response).to be_ok
  end

  context 'with a larger minimum' do
    let(:min) { 30 }

    it 'passes arguments to the validator' do
      expect { post '/', { val: 20 } }.to raise_error(
        an_instance_of(Sinatra::ParamValidator::ValidationFailedError).and(
          having_attributes(errors: { val: ['Parameter cannot be less than 30'] })
        )
      )
    end
  end
end
