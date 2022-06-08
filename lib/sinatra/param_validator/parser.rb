# frozen_string_literal: true

require 'delegate'

require_relative 'parameter'
require_relative 'rule'

module Sinatra
  module ParamValidator
    # Run the definition in the given scope
    class Parser < SimpleDelegator
      attr_reader :errors

      def initialize(definition, context)
        super(context)
        @context = context
        @errors = {}

        instance_exec({}, &definition)
      end

      def param(key, type, **args)
        parameter = Parameter.new(@context.params[key], type, **args)
        @context.params[key] = parameter.coerced if @context.params.key? key
        @errors[key] = parameter.errors unless parameter.valid?
      rescue NameError
        raise 'Invalid parameter type'
      end

      def rule(name, *args, **kwargs)
        rule = Rule.new(name, @context.params, *args, **kwargs)
        unless rule.passes?
          @errors[:rules] ||= []
          @errors[:rules].push(rule.errors)
        end
      rescue NameError
        raise 'Invalid rule type'
      end
    end
  end
end
