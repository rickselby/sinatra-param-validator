# frozen_string_literal: true

module Sinatra
  module ParamValidator
    # Helpers for validating parameters
    module Helpers
      def filter_params
        params.each do |(param, value)|
          params[param] = nil if value == ''
          params[param] = [] if value == ['']
        end
      rescue StandardError => e
        raise "Filter params failed: #{e}"
      end

      def validate(identifier, args = {})
        validator = Definitions.get(identifier)
        validator.run(self, *args)
        validator.handle_failure unless validator.success?
      end
    end
  end
end
