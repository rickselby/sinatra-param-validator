# frozen_string_literal: true

require_relative 'validation_failed_error'
require_relative 'validator/form'
require_relative 'validator/url_param'

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

      def run(context)
        @errors = Parser.new(@definition, context).errors
      end

      def success?
        @errors.empty?
      end
    end
  end
end
