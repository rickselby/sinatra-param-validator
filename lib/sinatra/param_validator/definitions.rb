# frozen_string_literal: true

module Sinatra
  module ParamValidator
    # Store of valid definitions
    class Definitions
      def initialize
        @definitions = {}
      end

      def add(identifier, validator)
        raise "Validator already defined: '#{identifier}'" if @definitions.key? identifier

        @definitions[identifier] = validator
      end

      def get(identifier)
        raise "Unknown validator: '#{identifier}'" unless @definitions.key? identifier

        @definitions[identifier]
      end
    end
  end
end
