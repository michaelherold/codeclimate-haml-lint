require "dry-equalizer"

module CC
  module Engine
    # Generates categories for a given linter
    class Categories
      include Dry::Equalizer(:linter)

      # Instantiates a set of categories for a linter
      #
      # @api public
      # @param [String] linter the name of the linter to categorize
      def initialize(linter)
        @linter = linter
      end

      # Converts the categories into a JSON format
      #
      # @api public
      # @return [String]
      def to_json(*)
        ["Placeholder"].to_json
      end

      private

      # The name of the linter to categorize
      #
      # @api private
      # @return [String]
      attr_reader :linter
    end
  end
end
