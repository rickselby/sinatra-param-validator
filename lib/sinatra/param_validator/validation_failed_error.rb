# frozen_string_literal: true

module Sinatra
  module ParamValidator
    # Error raised when validation fails
    class ValidationFailedError < StandardError
      attr_reader :errors

      def initialize(errors, msg = nil)
        @errors = errors
        super(msg)
      end
    end
  end
end
