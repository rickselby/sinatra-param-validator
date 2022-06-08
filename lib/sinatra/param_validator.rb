# frozen_string_literal: true

require_relative 'param_validator/definitions'
require_relative 'param_validator/helpers'
require_relative 'param_validator/parser'
require_relative 'param_validator/validator'
require_relative 'param_validator/version'

module Sinatra
  # Module to register in Sinatra app
  module ParamValidator
    include Camelize

    def validator(identifier:, type: nil, &definition)
      class_name = 'Sinatra::ParamValidator::Validator'
      class_name = "#{class_name}::#{camelize(type)}" unless type.nil?
      settings.validator_definitions.add(identifier, Object.const_get(class_name).new(&definition))
    end

    def self.registered(app)
      app.helpers Helpers
      app.before { filter_params }
      app.set(:validator_definitions, Definitions.new)
      app.set(:validate) do |*identifiers|
        condition do
          identifiers.each { |identifier| validate identifier }
        end
      end
    end
  end
end
