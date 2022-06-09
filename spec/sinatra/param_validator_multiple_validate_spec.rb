# frozen_string_literal: true

require 'sinatra/test_helpers'

# Test that a single parameter can be validated multiple times
describe Sinatra::ParamValidator do
  include Sinatra::TestHelpers
  before do
    klass = described_class
    mock_app do
      register klass

      validator :identifier do
        param :max, Integer, required: true, message: 'Sample Error Message'
        param :max, Integer, min: 10, message: 'Another Error Message'
      end

      post '/', validate: :identifier do
        'OK'.to_json
      end
    end
  end

  it 'passes the message back with the exception' do
    expect { post '/' }.to raise_error(an_instance_of(Sinatra::ParamValidator::ValidationFailedError).and(
                                         having_attributes(errors: { max: ['Sample Error Message',
                                                                           'Another Error Message'] })
                                       ))
  end
end
