# frozen_string_literal: true

require_relative 'parameter/boolean'
require_relative 'parameter/date'
require_relative 'parameter/float'
require_relative 'parameter/integer'
require_relative 'parameter/string'
require_relative 'parameter/time'

module Sinatra
  module ParamValidator
    # Class to validate a single parameter
    class Parameter
      def self.new(value, type, **args)
        type = type.to_s.capitalize if type.is_a? Symbol
        klass = Object.const_get "Sinatra::ParamValidator::Parameter::#{type}"
        klass.new(value, **args)
      end
    end
  end
end
