# frozen_string_literal: true

require_relative 'common'

module Sinatra
  class ParamValidator
    class Parameter
      # Validation for integers
      class Float
        include Common
        include CommonMinMax

        def coerce
          return nil if @value.nil?

          Float(@value)
        end
      end
    end
  end
end
