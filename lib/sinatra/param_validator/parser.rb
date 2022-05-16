# frozen_string_literal: true

module Sinatra
  class ParamValidator
    # Parse a definition into a list of commands
    class Parser
      def self.parse(definition)
        new(definition).commands
      end

      attr_reader :commands

      def initialize(definition)
        @commands = []
        instance_exec({}, &definition)
      end

      def param(*args)
        @commands.push({ command: :param, args: args })
      end
    end
  end
end
