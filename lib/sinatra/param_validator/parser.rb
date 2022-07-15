# frozen_string_literal: true

require 'delegate'

require_relative 'invalid_parameter_error'
require_relative 'parameter'
require_relative 'rule'

module Sinatra
  module ParamValidator
    # Methods to add to the context for handling parameters
    module ValidatorMethods
      def _add_error(key, error)
        @__validator_errors[key] = @__validator_errors.fetch(key, []).concat(Array(error))
      end

      def param(key, type, default: nil, message: nil, **args, &block)
        parameter = Parameter.new(params[key], type, **args)
        _update_params_hash key, parameter, default
        if parameter.valid?
          _run_block(key, block) if block
        else
          _add_error key, message || parameter.errors
        end
      rescue NameError
        raise 'Invalid parameter type'
      end

      def rule(name, *args, **kwargs)
        rule = Rule.new(name, params, *args, **kwargs)
        unless rule.passes?
          @__validator_errors[:rules] ||= []
          @__validator_errors[:rules].push(rule.errors)
        end
      rescue NameError
        raise 'Invalid rule type'
      end

      def _run_block(key, block)
        args = block.arity == 1 ? [self] : []
        instance_exec(*args, &block)
      rescue InvalidParameterError => e
        _add_error key, e.message
      end

      def _update_params_hash(key, parameter, default)
        if params.key?(key)
          params[key] = parameter.coerced unless parameter.coerced.nil?
        elsif !default.nil?
          params[key] = default.respond_to?(:call) ? default.call : default
        end
      end
    end

    # Run the definition in the given scope
    class Parser
      attr_reader :errors

      def initialize(context)
        @context = context
      end

      def parse(definition, *args)
        @context.extend(ValidatorMethods)
        @context.instance_variable_set(:@__validator_errors, {})
        @context.instance_exec(*args, &definition)
        @errors = @context.instance_variable_get(:@__validator_errors)

        self
      end
    end
  end
end
