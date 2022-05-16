# frozen_string_literal: true

module Sinatra
  class ParamValidator
    # Class to validate a single parameter
    class Parameter
      attr_reader :errors

      def initialize(value, type, *args)
        @value = value
        @type = type
        @args = args
      end

      def valid?
        true
      end
    end
  end
end
