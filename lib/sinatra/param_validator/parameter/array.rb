# frozen_string_literal: true

require_relative 'common'

module Sinatra
  module ParamValidator
    class Parameter
      # Validation for arrays
      class Array
        include Common
        include CommonMinMaxLength

        private

        def coerce(value)
          return nil if value.nil?
          return value if value.is_a? ::Array
          return value.split(',') if value.is_a? ::String

          raise ArgumentError
        end
      end
    end
  end
end
