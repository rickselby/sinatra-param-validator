# frozen_string_literal: true

describe Sinatra::ParamValidator::Definitions, '.add' do
  let(:definitions) { described_class.new }

  it 'will allow a definition to be added' do
    expect { definitions.add :foo, :bar }.not_to raise_error
  end

  it 'will not allow a definition identifier to be used twice' do
    definitions.add :foo, :bar
    expect { definitions.add :foo, :bar }.to raise_error "Validator already defined: 'foo'"
  end
end
