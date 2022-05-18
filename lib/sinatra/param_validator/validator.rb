# frozen_string_literal: true

module Sinatra
  module ParamValidator
    # Definition of a single validator
    class Validator
      attr_reader :errors

      def initialize(&definition)
        @definition = definition
        @errors = []
      end

      def handle_failure
        raise 'Validation Failed'
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
