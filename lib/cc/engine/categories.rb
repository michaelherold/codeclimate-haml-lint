require "dry-equalizer"

module CC
  module Engine
    # Generates categories for a given linter
    class Categories
      include Dry::Equalizer(:linter)

      CATEGORIES = {
        "AltText" => "Compatibility",
        "ClassAttributeWithStaticValue" => "Style",
        "ClassesBeforeIds" => "Style",
        "ConsecutiveComments" => "Complexity",
        "ConsecutiveSilentScripts" => "Complexity",
        "EmptyObjectReference" => "Clarity",
        "EmptyScript" => "Clarity",
        "FinalNewline" => "Style",
        "HtmlAttributes" => "Complexity",
        "ImplicitDiv" => "Style",
        "Indentation" => "Style",
        "LeadingCommentSpace" => "Style",
        "LineLength" => "Style",
        "MultilinePipe" => "Complexity",
        "MultilineScript" => "Complexity",
        "ObjectReferenceAttributes" => "Clarity",
        "RuboCop" => "Style",
        "RubyComments" => "Bug Risk",
        "SpaceBeforeScript" => "Style",
        "SpaceInsideHashAttributes" => "Style",
        "TagName" => "Compatibility",
        "TrailingWhitespace" => "Style",
        "UnnecessaryInterpolation" => "Clarity",
        "UnnecessaryStringOutput" => "Clarity",
      }.freeze

      # Instantiates a set of categories for a linter
      #
      # @api public
      # @param [String] linter the name of the linter to categorize
      def initialize(linter)
        @linter = linter
      end

      # The name of the linter to categorize
      #
      # @api public
      # @return [String]
      attr_reader :linter

      # Checks whether the category is empty
      #
      # @api public
      # @return [Boolean]
      def empty?
        !category
      end

      # Converts the categories into a JSON format
      #
      # @api public
      # @return [String]
      def to_json(*args)
        if category
          [category].to_json(*args)
        end
      end

      private

      # The category for the linter
      #
      # @api private
      # @return [String]
      def category
        CATEGORIES[linter]
      end
    end
  end
end
