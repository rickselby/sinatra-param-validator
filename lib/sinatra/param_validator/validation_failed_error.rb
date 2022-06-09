# frozen_string_literal: true

module Sinatra
  module ParamValidator
    # Error raised when validation fails
    class ValidationFailedError < StandardError
      attr_reader :errors

      def initialize(errors)
        @errors = errors
        super("Validation failed: #{errors}")
      end
    end
  end
end
