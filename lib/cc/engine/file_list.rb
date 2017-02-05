require "forwardable"
require "haml_lint/runner"

module CC
  module Engine
    class FileList
      extend Enumerable
      extend Forwardable

      # Instantiates a new FileList
      #
      # @param [String] root the root directory to pull files from
      # @param [Hash] engine_config the engine configuration per the
      #   CodeClimate specification
      # @param [HamlLint::Configuration] linter_config the +haml_lint+
      #   configuration loaded from +.haml-lint.yml+
      def initialize(root:, engine_config:, linter_config:)
        @root = root
        @include_paths = engine_config["include_paths"] || %w(./)
        @linter_config = linter_config
      end

      def_delegators :filtered_files, :each, :to_a

      private

      attr_reader :include_paths
      attr_reader :linter_config
      attr_reader :root

      # Lists the absolute paths to every possible file in the root
      #
      # @api private
      # @return [Array<String>]
      def absolute_include_paths
        Dir.chdir(root) do
          include_paths.map { |path| Pathname.new(path).realpath.to_s }.compact
        end
      end

      # Lists the absolute paths to every file in the lists
      #
      # @api private
      # @return [Array<String>]
      def filtered_files
        absolute_include_paths.flat_map do |path|
          if Dir.exist?(path)
            runner.send(:extract_applicable_files, linter_config, files: [path])
          end
        end.compact
      end

      # A +haml_lint+ runner used to filter out possible files
      #
      # @api private
      # @return [HamlLint::Runner]
      def runner
        @runner ||= ::HamlLint::Runner.new
      end
    end
  end
end
