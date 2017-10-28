# frozen_string_literal: true

require 'dry-equalizer'

module CC
  module Engine
    # Generates the remediation points for a given linter
    class RemediationPoints
      include Dry::Equalizer(:points)

      # The default points for the smallest issue
      DEFAULT_POINTS = 50_000

      # Maps the linters to their remediation points
      POINTS = {
        'AlignmentTabs' => DEFAULT_POINTS,
        'AltText' => DEFAULT_POINTS * 2,
        'ClassAttributeWithStaticValue' => DEFAULT_POINTS,
        'ClassesBeforeIds' => DEFAULT_POINTS,
        'ConsecutiveComments' => DEFAULT_POINTS,
        'ConsecutiveSilentScripts' => DEFAULT_POINTS,
        'EmptyObjectReference' => DEFAULT_POINTS,
        'EmptyScript' => DEFAULT_POINTS,
        'FinalNewline' => DEFAULT_POINTS,
        'HtmlAttributes' => DEFAULT_POINTS * 2,
        'IdNames' => DEFAULT_POINTS * 5,
        'ImplicitDiv' => DEFAULT_POINTS,
        'Indentation' => DEFAULT_POINTS,
        'InlineStyles' => DEFAULT_POINTS * 2,
        'InstanceVariables' => DEFAULT_POINTS * 3,
        'LeadingCommentSpace' => DEFAULT_POINTS,
        'LineLength' => DEFAULT_POINTS,
        'MultilinePipe' => DEFAULT_POINTS * 2,
        'MultilineScript' => DEFAULT_POINTS,
        'ObjectReferenceAttributes' => DEFAULT_POINTS * 2,
        'RepeatedId' => DEFAULT_POINTS * 2,
        'RuboCop' => DEFAULT_POINTS * 5,
        'RubyComments' => DEFAULT_POINTS,
        'SpaceBeforeScript' => DEFAULT_POINTS,
        'SpaceInsideHashAttributes' => DEFAULT_POINTS,
        'Syntax' => DEFAULT_POINTS,
        'TagName' => DEFAULT_POINTS,
        'TrailingWhitespace' => DEFAULT_POINTS,
        'UnnecessaryInterpolation' => DEFAULT_POINTS,
        'UnnecessaryStringOutput' => DEFAULT_POINTS,
        'ViewLength' => DEFAULT_POINTS * 4
      }.freeze

      # Instantiates a remediate points value for a linter
      #
      # @example
      #   CC::Engine::RemediationPoints.new("TagName")
      #
      # @api public
      # @param [String] linter the name of the linter to remediate
      def initialize(linter)
        @linter = linter
      end

      # Checks whether there is a points assignment for the linter
      #
      # @example
      #   points = CC::Engine::RemediationPoints.new("TagName")
      #   points.empty?  #=> false
      #
      # @api public
      # @return [Boolean]
      def empty?
        !points
      end

      # The number of remediation points for the linter
      #
      # @example
      #   points = CC::Engine::RemediationPoints.new("TagName")
      #   points.points
      #
      # @api public
      # @return [Integer]
      def points
        POINTS[linter]
      end

      # Converts the remediation points into a JSON format
      #
      # @example
      #   points = CC::Engine::RemediationPoints.new("TagName")
      #   points.to_json
      #
      # @api public
      # @return [String] a JSON document of the remediation points
      def to_json(*args)
        return unless points

        points.to_json(*args)
      end

      private

      # The name of the linter to remediate
      #
      # @api private
      # @return [String]
      attr_reader :linter
    end
  end
end
