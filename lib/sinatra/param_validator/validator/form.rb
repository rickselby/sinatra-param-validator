# frozen_string_literal: true

module Sinatra
  module ParamValidator
    class Validator
      # A form validator
      class Form < Validator
        def handle_failure(context)
          case context.request.preferred_type.to_s
          when 'application/json' then return json_failure(context)
          when 'text/html'
            return flash_failure(context) if defined? Sinatra::Flash
          end

          context.halt 400
        end

        def run(context)
          @original_params = context.params
          super(context)
        end

        private

        def json_failure(context)
          context.halt 400, { error: 'Validation failed', fields: @errors }.to_json
        end

        def flash_failure(context)
          context.flash[:params] = @original_params
          context.flash[:form_errors] = @errors
          context.redirect context.back
        end
      end
    end
  end
end
