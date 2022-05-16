# frozen_string_literal: true

require_relative 'param_validator/definitions'
require_relative 'param_validator/version'

module Sinatra
  # Validator for param
  class ParamValidator
    def self.define(identifier, &definition)
      Sinatra::ParamValidator::Definitions.add(identifier, new(definition))
    end

    def initialize(definition)
      @definition = definition
    end

    def run
      # TODO
    end
  end
end
