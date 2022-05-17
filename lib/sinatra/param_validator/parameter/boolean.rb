# frozen_string_literal: true

require_relative 'common'

module Sinatra
  module ParamValidator
    class Parameter
      # Validation for strings
      class Boolean
        include Common

        def coerce(value)
          return nil if value.nil?

          case value.to_s
          when /^(false|f|no|n|0)$/i then false
          when /^(true|t|yes|y|1)$/i then true
          else raise ArgumentError
          end
        end
      end
    end
  end
end
