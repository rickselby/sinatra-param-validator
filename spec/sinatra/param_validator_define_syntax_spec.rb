# frozen_string_literal: true

RSpec.describe Sinatra::ParamValidator, '.define' do
  subject(:run_validator) do
    Sinatra::ParamValidator::Definitions.get(:identifier).run
  end

  before do
    described_class.define :identifier do
      param :boolean, :boolean, required: true
      param :date, Date, required: true
      param :float, Float, required: true
      param :integer, Integer, required: true
      param :string, String, required: true, blank: false
    end
  end

  it 'is valid syntax' do
    run_validator
  end
end
