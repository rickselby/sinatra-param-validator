# frozen_string_literal: true

require 'date'
require_relative 'common'

module Sinatra
  class ParamValidator
    class Parameter
      # Validation for integers
      class Date
        include Common
        include CommonMinMax

        def coerce(value)
          return nil if value.nil?

          ::Date.parse(value)
        end
      end
    end
  end
end
