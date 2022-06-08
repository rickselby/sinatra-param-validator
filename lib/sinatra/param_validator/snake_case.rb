# frozen_string_literal: true

module Sinatra
  module ParamValidator
    # Helpers for validating parameters
    module SnakeCase
      def snake_case(string)
        string.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase
      end
    end
  end
end
