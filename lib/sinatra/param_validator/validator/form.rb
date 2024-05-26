# frozen_string_literal: true

module Sinatra
  module ParamValidator
    class Validator
      # A form validator
      class Form < Validator
        # Helpers for Sinatra templates
        module Helpers
          def form_values(hash)
            hash = IndifferentHash[hash]
            flash.now[:params] = flash.now.key?(:params) ? hash.merge(flash.now[:params]) : hash
          end

          def form_value(field)
            flash[:params]&.fetch(field, nil)
          end

          def form_error?(field = nil)
            return !flash[:form_errors].nil? && !flash[:form_errors]&.empty? if field.nil?

            (flash[:form_errors] || {}).key?(field)
          end

          def form_errors(field)
            (flash[:form_errors] || {}).fetch(field, [])
          end

          def invalid_feedback(field, default = nil)
            fields = Array(field)
            (fields.any? { |f| form_error? f }) ? fields.map { |f| form_errors f }.flatten.join("<br />") : default
          end
        end

        def handle_failure(context)
          case context.request.preferred_type.to_s
          when "application/json" then return json_failure(context)
          when "text/html"
            return flash_failure(context) if defined? Sinatra::Flash
          end

          context.halt 400
        end

        def run(context)
          @original_params = context.params
          super
        end

        private

        def json_failure(context)
          context.halt 400, { error: "Validation failed", fields: @errors }.to_json
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
