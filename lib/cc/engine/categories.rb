require "dry-equalizer"

module CC
  module Engine
    # Generates categories for a given linter
    class Categories
      include Dry::Equalizer(:linter)

      # Maps the linters to their categories
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
      # @example
      #   CC::Engine::Categories.new("AltText")
      #
      # @api public
      # @param [String] linter the name of the linter to categorize
      def initialize(linter)
        @linter = linter
      end

      # The name of the linter to categorize
      #
      # @example
      #   CC::Engine::Categories.new("AltText").linter  #=> "AltText"
      #
      # @api public
      # @return [String]
      attr_reader :linter

      # Checks whether the category is empty
      #
      # @example
      #   CC::Engine::Categories.new("AltText").empty?  #=> false
      #
      # @api public
      # @return [Boolean]
      def empty?
        !category
      end

      # Converts the categories into a JSON format
      #
      # @example
      #   CC::Engine::Categories.new("AltText").to_json  #=> ["Compatibility"]
      #
      # @api public
      # @return [String] a JSON document of the compatibilities
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
