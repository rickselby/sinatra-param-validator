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

      def initialize(context)
        super(context)
        @context = context
        @errors = {}
      end

      def parse(definition, *args)
        instance_exec(*args, &definition)

        self
      end

      def add_error(key, error)
        @errors[key] = @errors.fetch(key, []).concat(Array(error))
      end

      def param(key, type, default: nil, message: nil, **args, &block)
        parameter = Parameter.new(@context.params[key], type, **args)
        update_params_hash key, parameter, default
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

      private

      def run_block(key, block)
        args = block.arity == 1 ? [self] : []
        @context.instance_exec(*args, &block)
      rescue InvalidParameterError => e
        add_error key, e.message
      end

      def update_params_hash(key, parameter, default)
        if @context.params.key?(key)
          @context.params[key] = parameter.coerced unless parameter.coerced.nil?
        elsif !default.nil?
          @context.params[key] = default.respond_to?(:call) ? default.call : default
        end
      end
    end
  end
end
