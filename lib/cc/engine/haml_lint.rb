# frozen_string_literal: true

module CC
  module Engine
    class HamlLint
      def initialize(root:, config:, io:)
        @root = root
        @config = config || {}
        @io = io
      end

      def run
      end
    end
  end
end
