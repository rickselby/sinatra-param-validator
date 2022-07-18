# frozen_string_literal: true

module Sinatra
  module ParamValidator
    # Helpers for validating parameters
    module Helpers
      def filter_params
        params.each do |(param, value)|
          params[param] = nil if value == ''
          params[param] = [] if value == ['']
        end
      rescue StandardError => e
        raise "Filter params failed: #{e}"
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
          @_validator_errors[:rules] ||= []
          @_validator_errors[:rules].push(rule.errors)
        end
      rescue NameError
        raise 'Invalid rule type'
      end

      def validate(klass, identifier)
        identifier = Identifier.new(identifier) if identifier.is_a? Symbol
        definition = settings.validator_definitions.get(identifier.identifier)
        validator = klass.new(&definition)
        validator.run(self, *identifier.args)
        validator.handle_failure(self) unless validator.success?
      end

      def _add_error(key, error)
        @_validator_errors[key] = @_validator_errors.fetch(key, []).concat(Array(error))
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
  end
end
