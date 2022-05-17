# frozen_string_literal: true

require_relative 'common'

module Sinatra
  class ParamValidator
    class Parameter
      # Validation for integers
      class Integer
        include Common
        include CommonMinMax

        def coerce(value)
          return nil if value.nil?

          Integer(value, 10)
        end
      end
    end
  end
end
