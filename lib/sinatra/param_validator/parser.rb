# frozen_string_literal: true

require 'delegate'

require_relative 'invalid_parameter_error'
require_relative 'parameter'
require_relative 'rule'

module Sinatra
  module ParamValidator
    # Run the definition in the given scope
    class Parser < SimpleDelegator
      attr_reader :errors

      def initialize(definition, context, *args)
        super(context)
        @context = context
        @errors = {}

        instance_exec(*args, &definition)
      end

      def add_error(key, error)
        @errors[key] = @errors.fetch(key, []).concat(Array(error))
      end

      def block(&block)
        run_block :block, block
      end

      def param(key, type, message: nil, **args, &block)
        parameter = Parameter.new(@context.params[key], type, **args)
        @context.params[key] = parameter.coerced if @context.params.key?(key) && parameter.coerced
        if parameter.valid?
          run_block(key, block) if block
        else
          add_error key, message || parameter.errors
        end
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

      def run_block(key, block)
        args = block.arity == 1 ? [self] : []
        @context.instance_exec(*args, &block)
      rescue InvalidParameterError => e
        add_error key, e.message
      end
    end
  end
end
