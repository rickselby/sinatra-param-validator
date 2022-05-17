# frozen_string_literal: true

module Sinatra
  class ParamValidator
    # Helpers for validating parameters
    module Helpers
      def validate(validator, args = {})
        validator.context = self
        validator.run(*args)
        validator.handle_failure unless validator.success?
      end
    end
  end
end
