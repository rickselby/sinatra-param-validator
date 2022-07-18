# frozen_string_literal: true

require 'delegate'

require_relative 'invalid_parameter_error'
require_relative 'parameter'
require_relative 'rule'

module Sinatra
  module ParamValidator
    # Run the definition in the given scope
    class Parser
      attr_reader :errors

      def initialize(context)
        @context = context
      end

      def parse(definition, *args)
        @context.instance_variable_set(:@_validator_errors, {})
        @context.instance_exec(*args, &definition)
        @errors = @context.instance_variable_get(:@_validator_errors)

        self
      end
    end
  end
end
