# frozen_string_literal: true

module Sinatra
  module ParamValidator
    class Rule
      # Rule to enforce all given params, or none of them
      class AllOrNoneOf
        attr_reader :errors

        def initialize(params, *fields, **_kwargs)
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
          return if count.zero? || count == fields.count

          @errors.push "All or none of [#{fields.join ', '}] must be provided"
        end
      end
    end
  end
end
