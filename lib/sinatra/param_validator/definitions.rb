# frozen_string_literal: true

module Sinatra
  module ParamValidator
    # Store of valid definitions
    module Definitions
      @definitions = {}

      module_function

      def add(identifier, validator)
        @definitions[identifier] = validator
      end

      def get(identifier)
        raise "Unknown validator: '#{identifier}'" unless @definitions.key? identifier

        @definitions[identifier]
      end
    end
  end
end
