# frozen_string_literal: true

require_relative "camelize"
require_relative "parameter/array"
require_relative "parameter/boolean"
require_relative "parameter/date"
require_relative "parameter/float"
require_relative "parameter/hash"
require_relative "parameter/integer"
require_relative "parameter/string"
require_relative "parameter/time"

module Sinatra
  module ParamValidator
    # Load and validate a single parameter
    class Parameter
      class << self
        include Camelize

        def new(value, type, **args)
          type = camelize(type) if type.is_a? Symbol
          klass = Object.const_get "Sinatra::ParamValidator::Parameter::#{type}"
          klass.new(value, **args)
        end
      end
    end
  end
end
