# frozen_string_literal: true

require_relative 'common'

module Sinatra
  module ParamValidator
    class Parameter
      # Validation for strings
      class String
        include Common

        def coerce(value)
          return nil if value.nil?

          String(value)
        end

        private

        def blank(enabled)
          @errors.push 'Parameter cannot be blank' if !enabled && !@coerced&.match?(/\S/)
        end

        def format(format_string)
          @errors.push "Parameter must match the format #{format_string}" unless @coerced&.match?(format_string)
        end

        def max_length(length)
          @errors.push "Parameter cannot have length greater than #{length}" unless @coerced.length <= length
        end

        def min_length(length)
          @errors.push "Parameter cannot have length less than #{length}" unless @coerced.length >= length
        end
      end
    end
  end
end
