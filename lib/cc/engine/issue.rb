require "dry-equalizer"
require "cc/engine/categories"
require "cc/engine/location"

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
        @categories = Categories.new(linter)
        @description = message
        @location = Location.from_haml_lint(location: location, path: path, root: root)
        @severity = severity_from(severity)
      end

      # The categories of the issue
      #
      # @api public
      # @return [CC::Engine::Categories]
      attr_reader :categories

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

      # The name of the check that caught the issue
      #
      # @api public
      # @return [String]
      def check_name
        "HamlLint/#{linter}"
      end

      # Converts the issue into a Hash
      #
      # @api public
      # @return [Hash]
      def to_h
        {}.tap do |hash|
          hash[:type] = type
          hash[:check_name] = check_name
          hash[:description] = description
          hash[:categories] = categories
          hash[:location] = location
          hash[:severity] = severity
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

      # Converts the HamlLint severity ontology into the Code Climate one
      #
      # @api private
      # @param [String] severity the severity of the issue in HamlLint ontology
      # @return [String]
      def severity_from(severity)
        case severity
        when "warning" then "normal"
        when "error" then "critical"
        else "info"
        end
      end
    end
  end
end
