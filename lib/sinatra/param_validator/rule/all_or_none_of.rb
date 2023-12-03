# frozen_string_literal: true

require_relative "common"

module Sinatra
  module ParamValidator
    class Rule
      # Rule to enforce all given params, or none of them
      class AllOrNoneOf
        include Common

        def validate
          return if count.zero? || count == @fields.count

          @errors.push "All or none of [#{@fields.join ', '}] must be provided"
        end
      end
    end
  end
end
