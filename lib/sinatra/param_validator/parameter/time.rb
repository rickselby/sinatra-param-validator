# frozen_string_literal: true

require "time"
require_relative "common"

module Sinatra
  module ParamValidator
    class Parameter
      # Validation for times
      class Time
        include Common
        include CommonMinMax

        private

        def coerce(value)
          return nil if value.nil?
          return value if value.is_a? ::Time

          ::Time.parse(value)
        end
      end
    end
  end
end
