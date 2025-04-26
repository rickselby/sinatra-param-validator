# frozen_string_literal: true

module Sinatra
  module ParamValidator
    # Definition of a single validator
    class Validator
      attr_reader :errors

      def initialize(&definition)
        @definition = definition
        @errors = {}
      end

      def handle_failure(_context)
        raise ValidationFailedError, @errors
      end

      def run(context, *)
        context.instance_variable_set(:@_validator_errors, {})
        context.instance_exec(*, &@definition)
        @errors = context.remove_instance_variable(:@_validator_errors)
      rescue InvalidParameterError => e
        @errors[:general] = [e.message]
      end

      def success?
        @errors.empty?
      end

      @validators = []

      class << self
        attr_reader :validators

        def inherited(subclass)
          super
          @validators << subclass
        end
      end
    end
  end
end

require_relative "validation_failed_error"
require_relative "validator/form"
require_relative "validator/url_param"
