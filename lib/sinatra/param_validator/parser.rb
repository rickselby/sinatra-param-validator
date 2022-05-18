# frozen_string_literal: true

require 'delegate'

require_relative 'parameter'
require_relative 'rule'

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

      def param(key, type, **args)
        parameter = Parameter.new(@context.params[key], type, **args)
        @context.params[key] = parameter.coerced
        @errors.push(parameter.errors) unless parameter.valid?
      rescue NameError
        raise 'Invalid parameter type'
      end

      def rule(name, *args, **kwargs)
        rule = Rule.new(name, @context.params, *args, **kwargs)
        @errors.push(rule.errors) unless rule.passes?
      rescue NameError
        raise 'Invalid rule type'
      end
    end
  end
end
