# frozen_string_literal: true

require_relative 'param_validator/definitions'
require_relative 'param_validator/parser'
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
      Parser.parse(@definition)
    end
  end
end
