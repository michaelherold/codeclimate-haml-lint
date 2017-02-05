require "dry-equalizer"
require "cc/engine/categories"

module CC
  module Engine
    # Transforms the HamlLint JSON format to the one expected by Code Climate
    class Issue
      include Dry::Equalizer(:categories, :check_name, :description, :location, :root, :severity)

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
        @root = Pathname.new(root).realpath.to_s
        @categories = Categories.new(linter)
        @description = message
        @location = location_from(path, location)
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
      # @return [Hash]
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

      # Converts the issue into a JSON document
      #
      # @api public
      # @return [String]
      def to_json
        {}.tap do |hash|
          hash[:type] = type
          hash[:check_name] = check_name
          hash[:description] = description
          hash[:categories] = categories
          hash[:location] = location
          hash[:severity] = severity
        end.to_json
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

      # The root path where the issue was detected
      #
      # @api private
      # @return [String]
      attr_reader :root

      # Converts the HamlLint location format into the Code Climate format
      #
      # @api private
      # @return [Hash]
      def location_from(path, location)
        {
          path: path.sub(%r{^#{root}/}, ""),
          lines: {
            begin: location[:line],
            end: location[:line],
          },
        }
      end

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
