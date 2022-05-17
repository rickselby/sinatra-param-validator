# frozen_string_literal: true

require 'delegate'

module Sinatra
  module ParamValidator
    # Parse a definition into a list of commands
    class Parser < SimpleDelegator
      attr_reader :errors

      def self.parse(definition, context)
        new(definition, context)
      end

      def initialize(definition, context)
        super(context)
        @context = context
        @errors = []

        instance_exec({}, &definition)
      end

      def param(key, type, args)
        parameter = Parameter.new(@context.params[key], type, **args)
        @context.params[key] = parameter.coerced
        @errors.push(parameter.errors) unless parameter.valid?
      rescue NameError => e
        p e
        raise 'Invalid parameter type'
      end
    end
  end
end
