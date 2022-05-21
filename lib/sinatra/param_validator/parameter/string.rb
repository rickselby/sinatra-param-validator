# frozen_string_literal: true

require_relative 'common'

module Sinatra
  module ParamValidator
    class Parameter
      # Validation for strings
      class String
        include Common
        include CommonMinMaxLength

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
