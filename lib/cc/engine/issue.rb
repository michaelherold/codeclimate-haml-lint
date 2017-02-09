require "dry-equalizer"
require "cc/engine/categories"
require "cc/engine/content"
require "cc/engine/fingerprint"
require "cc/engine/location"
require "cc/engine/remediation_points"
require "cc/engine/severity"

module CC
  module Engine
    # Transforms the HamlLint JSON format to the one expected by Code Climate
    class Issue
      include Dry::Equalizer(:categories, :check_name, :description, :location, :severity)

      # Instantiates a new Code Climate issue
      #
      # @api public
      # @param [String] linter_name the name of the linter that threw the error
      # @param [Hash] location a container with the line of the issue
      # @param [String] message the description of the issue
      # @param [String] path the path to the file where the issue was detected
      # @param [String] root the root path of the analysis
      # @param [String] severity the severity of the issue in HamlLint terminology
      def initialize(linter_name:, location:, message:, path:, root: "", severity:)
        @linter = linter_name
        @description = message
        @location = Location.from_haml_lint(location: location, path: path, root: root)
        @severity = Severity.from_haml_lint(severity)
      end

      # The description of the issue
      #
      # @api public
      # @return [String]
      attr_reader :description

      # The location of the issue in the file
      #
      # @api public
      # @return [CC::Engine::Location]
      attr_reader :location

      # The severity of the issue in Code Climate terminology
      #
      # @api public
      # @return [String]
      attr_reader :severity

      # The categories of the issue
      #
      # @api public
      # @return [CC::Engine::Categories]
      def categories
        @categories ||= Categories.new(linter)
      end

      # The name of the check that caught the issue
      #
      # @api public
      # @return [String]
      def check_name
        "HamlLint/#{linter}"
      end

      # The content for an issue
      #
      # @api public
      # @return [CC::Engine::Content]
      def content
        @content ||= Content.new(linter)
      end

      # A unique identifier for overridable issues
      #
      # @apu public
      # @return [CC::Engine::Fingerprint]
      def fingerprint
        @fingerprint ||= Fingerprint.new(location.path, linter, description)
      end

      # The difficulty to fix an issue
      #
      # @api public
      # @return [CC::Engine::RemediationPoints]
      def points
        @points ||= RemediationPoints.new(linter)
      end

      # Converts the issue into a Hash
      #
      # @api public
      # @return [Hash]
      def to_h
        {
          type: type,
          check_name: check_name,
          description: description,
          location: location,
          severity: severity,
        }.tap do |hash|
          hash[:categories] = categories unless categories.empty?
          hash[:content] = content.body unless content.empty?
          hash[:fingerprint] = fingerprint unless fingerprint.empty?
          hash[:remediation_points] = points unless points.empty?
        end
      end

      # Converts the issue into a JSON document
      #
      # @api public
      # @return [String]
      def to_json(*)
        to_h.to_json
      end

      # The type of the issue in Code Climate's terminology
      #
      # @api public
      # @return [String]
      def type
        "issue"
      end

      private

      # The name of the linter that caught the issue
      #
      # @api private
      # @return [String]
      attr_reader :linter
    end
  end
end
