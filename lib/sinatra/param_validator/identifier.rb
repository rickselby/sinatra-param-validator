# frozen_string_literal: true

module Sinatra
  module ParamValidator
    # Class to hold a validator identifier plus arguments
    class Identifier
      attr_reader :identifier, :args

      def initialize(identifier, *args)
        @identifier = identifier
        @args = args
      end
    end
  end
end
