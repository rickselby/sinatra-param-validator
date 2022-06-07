# frozen_string_literal: true

module Sinatra
  module ParamValidator
    # Helpers for validating parameters
    module Camelize
      def camelize(symbol)
        symbol.to_s.split('_').map(&:capitalize).join
      end
    end
  end
end
