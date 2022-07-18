# frozen_string_literal: true

RSpec.describe Sinatra::ParamValidator::Helpers, '.rule' do
  include described_class

  let(:params) { {} }

  it 'raises an error for a parameter missing from params' do
    expect { rule :any_of, :a, :b }.to raise_error Sinatra::ParamValidator::InvalidParameterError
  end

  context 'with the parameter' do
    let(:params) { { a: :a } }

    it 'does not raise an error if the validation passes' do
      expect { rule :any_of, :a, :b }.not_to raise_error
    end
  end
end
