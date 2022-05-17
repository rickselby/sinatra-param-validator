# frozen_string_literal: true

require_relative 'parameter/float'
require_relative 'parameter/integer'
require_relative 'parameter/string'

module Sinatra
  class ParamValidator
    # Class to validate a single parameter
    class Parameter
      def self.new(value, type, *args)
        klass = Object.const_get "Sinatra::ParamValidator::Parameter::#{type}"
        klass.new(value, *args)
      end
    end
  end
end
