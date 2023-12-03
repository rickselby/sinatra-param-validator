# frozen_string_literal: true

module Sinatra
  module ParamValidator
    class Parameter
      # Common validation methods shared between parameters
      module Common
        attr_reader :coerced, :errors

        def initialize(value, **options)
          @errors = []
          @options = options

          begin
            @coerced = coerce value
          rescue ArgumentError
            @errors.push "'#{value}' is not a valid #{self.class}"
            return
          end

          validate_options
          validate unless nil_and_ok?
        end

        def valid?
          @errors.empty?
        end

        def validate_options
          @options.each_key { |key| raise "Unknown option '#{key}' for #{self.class}" unless respond_to? key }
        end
        private :validate_options

        def validate
          @options.each { |key, value| method(key).call(value) }
        end
        private :validate

        def in(options)
          @errors.push "Parameter must be within #{options}" unless in? options
        end

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

        def nillable(_)
          # Does nothing. Allows other tests to ignore nil values if present in the options
        end

        def nil_and_ok?
          @options.key?(:nillable) && @coerced.nil?
        end
        private :nil_and_ok?

        def required(enabled)
          @errors.push "Parameter is required" if enabled && @coerced.nil?
        end
      end

      # min/max tests
      module CommonMinMax
        def max(maximum)
          return if @coerced.respond_to?(:<=) && @coerced <= maximum

          @errors.push "Parameter cannot be greater than #{maximum}"
        end

        def min(minimum)
          return if @coerced.respond_to?(:>=) && @coerced >= minimum

          @errors.push "Parameter cannot be less than #{minimum}"
        end
      end

      # min/max length tests
      module CommonMinMaxLength
        def max_length(length)
          return if @coerced.respond_to?(:length) && @coerced.length <= length

          @errors.push "Parameter cannot have length greater than #{length}"
        end

        def min_length(length)
          return if @coerced.respond_to?(:length) && @coerced.length >= length

          @errors.push "Parameter cannot have length less than #{length}"
        end
      end
    end
  end
end
