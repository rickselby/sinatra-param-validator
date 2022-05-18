# frozen_string_literal: true

module Sinatra
  module ParamValidator
    class Parameter
      # Common validation methods shared between parameters
      module Common
        attr_reader :coerced, :errors

        def initialize(value, **options)
          @errors = []
          @coerced = coerce value

          validate(options)
        rescue ArgumentError
          @errors.push "'#{value}' is not a valid #{self.class}"
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
            options.include? @coerced
          else
            Array(options).include? @coerced
          end
        end
        private :in?

        def is(option_value)
          @errors.push "Parameter must be #{option_value}" unless @coerced == option_value
        end
        private :is

        def required(enabled)
          @errors.push 'Parameter is required' if enabled && @coerced.nil?
        end
        private :required
      end

      # min/max tests
      module CommonMinMax
        def max(maximum)
          @errors.push "Parameter cannot be greater than #{maximum}" unless @coerced <= maximum
        end
        private :max

        def min(minimum)
          @errors.push "Parameter cannot be less than #{minimum}" unless @coerced >= minimum
        end
        private :min
      end

      # min/max length tests
      module CommonMinMaxLength
        def max_length(length)
          @errors.push "Parameter cannot have length greater than #{length}" unless @coerced.length <= length
        end
        private :max_length

        def min_length(length)
          @errors.push "Parameter cannot have length less than #{length}" unless @coerced.length >= length
        end
        private :min_length
      end
    end
  end
end
