# frozen_string_literal: true

module Sinatra
  module ParamValidator
    # Helpers for validating parameters
    module Helpers
      def validate(identifier, args = {})
        validator = Definitions.get(identifier)
        validator.context = self
        validator.run(*args)
        validator.handle_failure unless validator.success?
      end
    end
  end
end
