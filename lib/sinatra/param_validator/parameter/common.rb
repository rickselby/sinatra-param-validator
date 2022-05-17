# frozen_string_literal: true

module Sinatra
  class ParamValidator
    class Parameter
      # Validation for integers
      module Common
        attr_reader :errors, :value

        def initialize(value, **kwargs)
          @errors = []
          @value = value

          validate(kwargs)
        end

        def valid?
          @errors.empty?
        end

        def validate(options)
          options.each do |key, value|
            raise "Unknown option '#{key}' for #{self.class}" unless respond_to? key, true

            method(key).call(value)
          end
        end

        def in(options)
          @errors.push "Parameter must be within #{options}" unless in? options
        end
        private :in

        def in?(options)
          case options
          when Range
            options.include? @value
          else
            Array(options).include? @value
          end
        end
        private :in?

        def is(option_value)
          @errors.push "Parameter must be #{option_value}" unless @value == option_value
        end
        private :is

        def required(enabled)
          @errors.push 'Parameter is required' if enabled && @value.nil?
        end
        private :required
      end

      # Common tests for numeric types
      module CommonNumeric
        def max(maximum)
          @errors.push "Parameter cannot be greater than #{maximum}" unless @value.nil? || @value <= maximum
        end
        private :max

        def min(minimum)
          @errors.push "Parameter cannot be less than #{minimum}" unless @value.nil? || @value >= minimum
        end
        private :min
      end
    end
  end
end
