# frozen_string_literal: true

module Sinatra
  module ParamValidator
    class Validator
      # A URL parameter; handle validation failure with
      class UrlParam < Validator
        def handle_failure(context)
          context.halt 403
        end
      end
    end
  end
end
