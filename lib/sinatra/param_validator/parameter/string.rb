# frozen_string_literal: true

module Sinatra
  class ParamValidator
    class Parameter
      # Validation for strings
      class String
        attr_reader :errors, :value

        def initialize(value, **kwargs)
          @errors = []
          @value = value

          validate(kwargs)
        end

        def coerce
          return nil if @value.nil?

          String(@value)
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

        private

        def blank(enabled)
          @errors.push 'Parameter cannot be blank' if !enabled && !@value&.match?(/\S/)
        end

        def format(format_string)
          @errors.push "Parameter must match the format #{format_string}" unless @value&.match?(format_string)
        end

        def is(option_value)
          @errors.push "Parameter must be #{option_value}" unless @value == option_value
        end

        def in(options)
          @errors.push "Parameter must be within #{options}" unless in? options
        end

        def in?(options)
          case options
          when Range
            options.include? @value
          else
            Array(options).include? @value
          end
        end

        def required(enabled)
          @errors.push 'Parameter is required' if enabled && @value.nil?
        end
      end
    end
  end
end
