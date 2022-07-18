# frozen_string_literal: true

require_relative 'param_validator/camelize'
require_relative 'param_validator/definitions'
require_relative 'param_validator/helpers'
require_relative 'param_validator/identifier'
require_relative 'param_validator/invalid_parameter_error'
require_relative 'param_validator/parameter'
require_relative 'param_validator/rule'
require_relative 'param_validator/snake_case'
require_relative 'param_validator/validator'
require_relative 'param_validator/version'

module Sinatra
  # Module to register in Sinatra app
  module ParamValidator
    include Camelize

    def validator(identifier, &definition)
      settings.validator_definitions.add(identifier, definition)
    end

    def vi(identifier, *args)
      Identifier.new(identifier, *args)
    end

    class << self
      include SnakeCase

      def registered(app)
        app.helpers Helpers
        app.before { filter_params }
        app.set(:validator_definitions, Definitions.new)
        validator_conditional app, :validate, Sinatra::ParamValidator::Validator

        Sinatra::ParamValidator::Validator.validators.each do |validator|
          validator_conditional app, :"validate_#{snake_case(validator.to_s.split('::').last)}", validator
        end
      end

      def validator_conditional(app, name, klass)
        app.set(name) do |*identifiers|
          condition do
            identifiers.each { |identifier| validate klass, identifier }
          end
        end
      end
    end
  end
end
