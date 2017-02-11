require "forwardable"
require "haml_lint/configuration"

module CC
  module Engine
    # The Code Climate configuration to pass to the engine
    class Configuration
      extend Forwardable

      # Loads a configuration based on a file
      #
      # @api public
      # @param [String] filename the absolute path to the configuration file
      # @return [CC::Engine::Configuration]
      def self.from_file(filename = "/config.json")
        if File.exist?(filename)
          new(JSON.parse(File.read(filename)))
        else
          new
        end
      end

      # Instantiates a new engine configuration
      #
      # @api public
      # @param [Hash] attributes the attributes for the engine configuration
      # @return [CC::Engine::Configuration]
      def initialize(attributes = {})
        @attributes = attributes
      end

      # Configuration for the individual linters
      #
      # @api public
      # @return [Hash]
      def checks
        attribute_with_default("checks", {})
      end

      # The name of the HamlLint configuration file to use
      #
      # @api public
      # @return [String, NilClass]
      def config
        attribute_with_default("config", nil)
      end

      # Checks whether the engine is configured or not
      #
      # @api public
      # @return [Boolean]
      def enabled?
        attribute_with_default("enabled", true)
      end

      # The paths to exclude from analysis
      #
      # @api public
      # @return [Array<String>]
      def exclude_paths
        attribute_with_default("exclude_paths", [])
      end

      # The paths to include in analysis
      #
      # @api public
      # @return [Array<String>]
      def include_paths
        attribute_with_default("include_paths", %w(./))
      end

      # Converts the engine configuration to HamlLint configuration
      #
      # @api public
      # @return [HamlLint::Configuration]
      def to_linter_config
        ::HamlLint::Configuration.new(
          {"exclude" => exclude_paths, "linters" => {}}.tap do |config|
            checks.each do |linter, attrs|
              config["linters"][linter] = attrs
            end
          end
        )
      end

      private

      # @!method fetch
      #   @see Hash#fetch
      #   @api private
      #   @return [Object]
      def_delegators :@attributes, :fetch

      # @!method attribute_with_default
      #   @see Hash#fetch
      #   @api private
      #   @return [Object]
      alias_method :attribute_with_default, :fetch

      # The configuration passed in by Code Climate
      #
      # @api private
      # @return [Hash]
      attr_reader :attributes
    end
  end
end
