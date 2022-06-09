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

      def validate(klass, identifier)
        identifier = Identifier.new(identifier) if identifier.is_a? Symbol
        definition = settings.validator_definitions.get(identifier.identifier)
        validator = klass.new(&definition)
        validator.run(self, *identifier.args)
        validator.handle_failure(self) unless validator.success?
      end
    end
  end
end
