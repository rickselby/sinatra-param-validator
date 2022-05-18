# frozen_string_literal: true

module Sinatra
  module ParamValidator
    class Rule
      # Validation for strings
      class AnyOf
        attr_reader :errors

        def initialize(params, *fields)
          @errors = []
          @params = params
          @fields = fields

          validate(fields)
        end

        def passes?
          @errors.empty?
        end

        def validate(fields)
          count = fields.count { |f| @params.key? f }
          @errors.push "One of [#{fields.join ', '}] must be provided" if count < 1
        end
      end
    end
  end
end
