# frozen_string_literal: true

module Sinatra
  module ParamValidator
    # Error raised when validation fails
    class InvalidParameterError < StandardError
    end
  end
end
