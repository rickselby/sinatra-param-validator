# frozen_string_literal: true

require_relative 'common'

module Sinatra
  class ParamValidator
    class Parameter
      # Validation for strings
      class String
        include Common

        def coerce
          return nil if @value.nil?

          String(@value)
        end

        private

        def blank(enabled)
          @errors.push 'Parameter cannot be blank' if !enabled && !@value&.match?(/\S/)
        end

        def format(format_string)
          @errors.push "Parameter must match the format #{format_string}" unless @value&.match?(format_string)
        end
      end
    end
  end
end
