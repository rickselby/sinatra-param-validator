# frozen_string_literal: true

require "date"
require_relative "common"

module Sinatra
  module ParamValidator
    class Parameter
      # Validation for dates
      class Date
        include Common
        include CommonMinMax

        private

        def coerce(value)
          return nil if value.nil?
          return value if value.is_a? ::Date

          ::Date.parse(value)
        end
      end
    end
  end
end
