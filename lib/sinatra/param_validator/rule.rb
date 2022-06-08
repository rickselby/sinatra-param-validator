# frozen_string_literal: true

require_relative 'camelize'
require_relative 'rule/all_or_none_of'
require_relative 'rule/any_of'
require_relative 'rule/one_of'

module Sinatra
  module ParamValidator
    # Class to check a single rule
    class Rule
      class << self
        include Camelize

        def new(name, params, *args, **kwargs)
          name = camelize(name) if name.is_a? Symbol
          klass = Object.const_get "Sinatra::ParamValidator::Rule::#{name}"
          klass.new(params, *args, **kwargs)
        end
      end
    end
  end
end
