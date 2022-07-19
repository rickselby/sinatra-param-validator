# frozen_string_literal: true

module Sinatra
  module ParamValidator
    class Rule
      # Common validation methods shared between rules
      module Common
        attr_reader :errors

        def initialize(params, *fields, **_kwargs)
          @errors = []
          @params = params
          @fields = fields

          validate
        end

        def count
          @count ||= (@fields & @params.keys.map(&:to_sym)).count
        end

        def passes?
          @errors.empty?
        end
      end
    end
  end
end
