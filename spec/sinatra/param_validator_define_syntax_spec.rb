# frozen_string_literal: true

RSpec.describe Sinatra::ParamValidator, '.define' do
  subject(:validator) do
    Sinatra::ParamValidator::Validator.new do
      param :boolean, :boolean, required: true
      param :date, Date, required: true
      param :float, Float, required: true
      param :integer, Integer, required: true
      param :string, String, required: true, blank: false
    end
  end

  it 'is valid syntax' do
    expect { validator }.not_to raise_error
  end
end
