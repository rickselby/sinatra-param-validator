# frozen_string_literal: true

require_relative 'param_validator/camelize'
require_relative 'param_validator/definitions'
require_relative 'param_validator/helpers'
require_relative 'param_validator/parser'
require_relative 'param_validator/snake_case'
require_relative 'param_validator/validator'
require_relative 'param_validator/version'

module Sinatra
  # Module to register in Sinatra app
  module ParamValidator
    include Camelize
    class << self
      include SnakeCase
    end

    def validator(identifier, &definition)
      settings.validator_definitions.add(identifier, definition)
    end

    def self.registered(app)
      app.helpers Helpers
      app.before { filter_params }
      app.set(:validator_definitions, Definitions.new)
      app.set(:validate) do |*identifiers|
        condition do
          identifiers.each { |identifier| validate Sinatra::ParamValidator::Validator, identifier }
        end
      end

      Sinatra::ParamValidator::Validator.validators.each do |validator|
        name = snake_case validator.to_s.split('::').last
        app.set(:"validate_#{name}") do |*identifiers|
          condition do
            identifiers.each { |identifier| validate validator, identifier }
          end
        end
      end
    end
  end
end
