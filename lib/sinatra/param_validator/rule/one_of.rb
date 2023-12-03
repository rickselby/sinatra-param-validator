# frozen_string_literal: true

require_relative "common"

module Sinatra
  module ParamValidator
    class Rule
      # Rule to enforce only one of the given params has been given
      class OneOf
        include Common

        def validate
          @errors.push "Only one of [#{@fields.join ', '}] is allowed" if count > 1
          @errors.push "One of [#{@fields.join ', '}] must be provided" if count < 1
        end
      end
    end
  end
end
