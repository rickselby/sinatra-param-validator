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

      def run(context, *args)
        @errors = Parser.new(context).parse(@definition, *args).errors
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

require_relative 'validation_failed_error'
require_relative 'validator/form'
require_relative 'validator/url_param'
