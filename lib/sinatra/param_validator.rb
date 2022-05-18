# frozen_string_literal: true

require_relative 'param_validator/definitions'
require_relative 'param_validator/helpers'
require_relative 'param_validator/parser'
require_relative 'param_validator/validator'
require_relative 'param_validator/version'

module Sinatra
  # Module to register in Sinatra app
  module ParamValidator
    def validator(identifier, &definition)
      Definitions.add(identifier, Validator.new(&definition))
    end

    def self.registered(app)
      app.helpers Helpers

      app.before do
        filter_params
      end

      app.set(:validate) do |*identifiers|
        condition do
          identifiers.each { |identifier| validate identifier }
        end
      end
    end
  end
end
