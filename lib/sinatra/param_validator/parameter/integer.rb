# frozen_string_literal: true

require_relative "common"

module Sinatra
  module ParamValidator
    class Parameter
      # Validation for integers
      class Integer
        include Common
        include CommonMinMax

        private

        def coerce(value)
          return nil if value.nil?
          return value if value.is_a? ::Integer

          Integer(value, 10)
        end
      end
    end
  end
end
