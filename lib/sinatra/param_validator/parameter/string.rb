# frozen_string_literal: true

require_relative 'common'

module Sinatra
  module ParamValidator
    class Parameter
      # Validation for strings
      class String
        include Common
        include CommonMinMaxLength

        def blank(enabled)
          @errors.push 'Parameter cannot be blank' if !enabled && !@coerced&.match?(/\S/)
        end

        def format(format_string)
          @errors.push "Parameter must match the format #{format_string}" unless @coerced&.match?(format_string)
        end

        private

        def coerce(value)
          return nil if value.nil?

          String(value)
        end
      end
    end
  end
end
