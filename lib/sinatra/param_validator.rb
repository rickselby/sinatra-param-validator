# frozen_string_literal: true

require_relative 'param_validator/definitions'
require_relative 'param_validator/helpers'
require_relative 'param_validator/parameter'
require_relative 'param_validator/parser'
require_relative 'param_validator/version'

module Sinatra
  # Validator for param
  class ParamValidator
    attr_reader :errors
    attr_writer :context

    def self.define(identifier, &definition)
      Sinatra::ParamValidator::Definitions.add(identifier, new(definition))
    end

    def initialize(definition)
      @definition = definition
      @errors = []
    end

    def handle_failure
      raise 'Validation Failed'
    end

    def run
      @errors = Parser.parse(@definition, @context).errors
    end

    def success?
      @errors.empty?
    end
  end
end
