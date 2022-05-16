# frozen_string_literal: true

require_relative 'param_validator/definitions'
require_relative 'param_validator/parameter'
require_relative 'param_validator/parser'
require_relative 'param_validator/version'

module Sinatra
  # Validator for param
  class ParamValidator
    attr_reader :errors

    def self.define(identifier, &definition)
      Sinatra::ParamValidator::Definitions.add(identifier, new(definition))
    end

    def initialize(definition)
      @definition = definition
      @errors = []
    end

    def run
      params = {} # TODO: replace with params hash from sinatra
      Parser.parse(@definition).each do |definition|
        command = case definition[:command]
                  when :param
                    Parameter.new(params[definition[:args][0]], *definition[:args][1..])
                  else
                    raise "Unknown command #{definition[:command]}"
                  end

        @errors.push(command.errors) unless command.valid?
      end
    end
  end
end
