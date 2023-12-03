# frozen_string_literal: true

require_relative "common"

module Sinatra
  module ParamValidator
    class Rule
      # Rule to enforce at least one of the given params exists
      class AnyOf
        include Common

        def validate
          @errors.push "One of [#{@fields.join ', '}] must be provided" if count < 1
        end
      end
    end
  end
end
