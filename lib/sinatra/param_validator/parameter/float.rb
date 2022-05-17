# frozen_string_literal: true

require_relative 'common'

module Sinatra
  module ParamValidator
    class Parameter
      # Validation for integers
      class Float
        include Common
        include CommonMinMax

        def coerce(value)
          return nil if value.nil?

          Float(value)
        end
      end
    end
  end
end
