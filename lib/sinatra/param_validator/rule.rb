# frozen_string_literal: true

require_relative 'rule/one_of'

module Sinatra
  module ParamValidator
    # Class to validate a single parameter
    class Rule
      def self.new(name, params, *args, **kwargs)
        name = camelize(name) if name.is_a? Symbol
        klass = Object.const_get "Sinatra::ParamValidator::Rule::#{name}"
        klass.new(params, *args, **kwargs)
      end

      def self.camelize(symbol)
        symbol.to_s.split('_').map(&:capitalize).join
      end
    end
  end
end
