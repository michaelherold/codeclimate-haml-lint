# frozen_string_literal: true

require 'dry-equalizer'
require 'cc/engine/categories'
require 'cc/engine/content'
require 'cc/engine/fingerprint'
require 'cc/engine/location'
require 'cc/engine/remediation_points'
require 'cc/engine/severity'

module CC
  module Engine
    # Transforms the HamlLint JSON format to the one expected by Code Climate
    class Issue
      include Dry::Equalizer(:categories, :check_name, :description, :location, :severity)

      # Instantiates a new Code Climate issue
      #
      # @example
      #   issue = CC::Engine::Issue.new(
      #     linter_name: "AltText",
      #     location: {line: 42},
      #     message: "This is a problem",
      #     path: "a.haml",
      #     root: "/tmp",
      #     severity: "error"
      #   )
      #
      # @api public
      # @param [String] linter_name the name of the linter that threw the error
      # @param [Hash] location a container with the line of the issue
      # @param [String] message the description of the issue
      # @param [String] path the path to the file where the issue was detected
      # @param [String] root the root path of the analysis
      # @param [String] severity the severity of the issue in HamlLint terminology
      # rubocop:disable Metrics/ParameterLists
      def initialize(linter_name:, location:, message:, path:, root: '', severity:)
        @linter = linter_name
        @description = message
        @location = Location.from_haml_lint(location: location, path: path, root: root)
        @severity = Severity.from_haml_lint(severity)
      end

      # The description of the issue
      #
      # @example
      #   issue = CC::Engine::Issue.new(
      #     linter_name: "AltText",
      #     location: {line: 42},
      #     message: "This is a problem",
      #     path: "a.haml",
      #     root: "/tmp",
      #     severity: "error"
      #   )
      #   issue.description  #=> "This is a problem"
      #
      # @api public
      # @return [String]
      attr_reader :description

      # The location of the issue in the file
      #
      # @example
      #   issue = CC::Engine::Issue.new(
      #     linter_name: "AltText",
      #     location: {line: 42},
      #     message: "This is a problem",
      #     path: "a.haml",
      #     root: "/tmp",
      #     severity: "error"
      #   )
      #   issue.location
      #
      # @api public
      # @return [CC::Engine::Location]
      attr_reader :location

      # The severity of the issue in Code Climate terminology
      #
      # @example
      #   issue = CC::Engine::Issue.new(
      #     linter_name: "AltText",
      #     location: {line: 42},
      #     message: "This is a problem",
      #     path: "a.haml",
      #     root: "/tmp",
      #     severity: "error"
      #   )
      #   issue.severity  #=> "critical"
      #
      # @api public
      # @return [String]
      attr_reader :severity

      # The categories of the issue
      #
      # @example
      #   issue = CC::Engine::Issue.new(
      #     linter_name: "AltText",
      #     location: {line: 42},
      #     message: "This is a problem",
      #     path: "a.haml",
      #     root: "/tmp",
      #     severity: "error"
      #   )
      #   issue.category  #=> ["Compability"]
      #
      # @api public
      # @return [CC::Engine::Categories]
      def categories
        @categories ||= Categories.new(linter)
      end

      # The name of the check that caught the issue
      #
      # @example
      #   issue = CC::Engine::Issue.new(
      #     linter_name: "AltText",
      #     location: {line: 42},
      #     message: "This is a problem",
      #     path: "a.haml",
      #     root: "/tmp",
      #     severity: "error"
      #   )
      #   issue.check_name  #=> "HamlLint/AltText"
      #
      # @api public
      # @return [String]
      def check_name
        "HamlLint/#{linter}"
      end

      # The content for an issue
      #
      # @example
      #   issue = CC::Engine::Issue.new(
      #     linter_name: "AltText",
      #     location: {line: 42},
      #     message: "This is a problem",
      #     path: "a.haml",
      #     root: "/tmp",
      #     severity: "error"
      #   )
      #   issue.content
      #
      # @api public
      # @return [CC::Engine::Content]
      def content
        @content ||= Content.new(linter)
      end

      # A unique identifier for overridable issues
      #
      # @example
      #   issue = CC::Engine::Issue.new(
      #     linter_name: "AltText",
      #     location: {line: 42},
      #     message: "This is a problem",
      #     path: "a.haml",
      #     root: "/tmp",
      #     severity: "error"
      #   )
      #   issue.fingerprint
      #
      # @api public
      # @return [CC::Engine::Fingerprint]
      def fingerprint
        @fingerprint ||= Fingerprint.new(location.path, linter, description)
      end

      # The difficulty to fix an issue
      #
      # @example
      #   issue = CC::Engine::Issue.new(
      #     linter_name: "AltText",
      #     location: {line: 42},
      #     message: "This is a problem",
      #     path: "a.haml",
      #     root: "/tmp",
      #     severity: "error"
      #   )
      #   issue.points
      #
      # @api public
      # @return [CC::Engine::RemediationPoints]
      def points
        @points ||= RemediationPoints.new(linter)
      end

      # Converts the issue into a Hash
      #
      # @example
      #   issue = CC::Engine::Issue.new(
      #     linter_name: "AltText",
      #     location: {line: 42},
      #     message: "This is a problem",
      #     path: "a.haml",
      #     root: "/tmp",
      #     severity: "error"
      #   )
      #   issue.to_h
      #   #=> {
      #     type: "issue",
      #     check_name: "HamlLint/AltText",
      #     description: "This is a problem",
      #     location: <#CC::Engine::Location>,
      #     severity: "critical",
      #     categories: ["Compatibility"],
      #     content: {body: "..."},
      #     fingerprint: <#CC::Engine::Fingerprint>,
      #     remediation_points: 50000
      #   }
      #
      # @api public
      # @return [Hash]
      def to_h
        extract_fields(:type, :check_name, :description, :location, :severity).tap do |hash|
          %i[categories content fingerprint points].each do |field|
            hash[field] = __send__(field) unless __send__(field).empty?
          end
        end
      end

      # Converts the issue into a JSON document
      #
      # @example
      #   issue = CC::Engine::Issue.new(
      #     linter_name: "AltText",
      #     location: {line: 42},
      #     message: "This is a problem",
      #     path: "a.haml",
      #     root: "/tmp",
      #     severity: "error"
      #   )
      #   issue.to_json
      #   #=> {
      #     "type": "issue",
      #     "check_name": "HamlLint/AltText",
      #     "description": "This is a problem",
      #     "location": {
      #       "path": "a.haml",
      #       "lines": {
      #         "begin": 42,
      #         "end": 42
      #       }
      #     },
      #     "severity": "critical",
      #     "categories": ["Compatibility"],
      #     "content": "...",
      #     "fingerprint": "...",
      #     "remediation_points": 50000
      #   }
      #
      # @api public
      # @return [String]
      def to_json(*)
        to_h.to_json
      end

      # The type of the issue in Code Climate's terminology
      #
      # @example
      #   issue = CC::Engine::Issue.new(
      #     linter_name: "AltText",
      #     location: {line: 42},
      #     message: "This is a problem",
      #     path: "a.haml",
      #     root: "/tmp",
      #     severity: "error"
      #   )
      #   issue.type  #=> "issue"
      #
      # @api public
      # @return [String]
      def type
        'issue'
      end

      private

      # The name of the linter that caught the issue
      #
      # @api private
      # @return [String]
      attr_reader :linter

      def extract_fields(*fields)
        {}.tap do |result|
          fields.each { |field| result[field] = __send__(field) }
        end
      end
    end
  end
end
