# frozen_string_literal: true

RSpec.describe Sinatra::ParamValidator::Helpers, '.param' do
  include described_class

  let(:params) { {} }

  it 'raises an error for a parameter missing from params' do
    expect { param :foo, String, required: true }.to raise_error Sinatra::ParamValidator::InvalidParameterError
  end

  context 'with the parameter' do
    let(:params) { { foo: 'foo' } }

    it 'does not raise an error if the validation passes' do
      expect { param :foo, String, required: true }.not_to raise_error
    end
  end
end
