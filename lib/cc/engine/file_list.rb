require "forwardable"
require "haml_lint/runner"
require "cc/engine/configuration"

module CC
  module Engine
    # Gathers a list of files to analyze with the engine
    class FileList
      include Enumerable
      extend Forwardable

      # Instantiates a new FileList
      #
      # @example
      #   CC::Engine::FileList.new(
      #     root: "/tmp",
      #     engine_config: CC::Engine::Configuration.new,
      #     linter_config: {}
      #   )
      #
      # @api public
      # @param [String] root the root directory to pull files from
      # @param [CC::Engine::Configuration] engine_config the engine
      # configuration per the CodeClimate specification
      # @param [HamlLint::Configuration] linter_config the +haml_lint+
      #   configuration loaded from +.haml-lint.yml+
      def initialize(root:, engine_config:, linter_config:)
        @root = root
        @include_paths = engine_config.include_paths
        @linter_config = linter_config
      end

      # @!method each
      #  Enumerates through the file list
      #
      #   @example
      #     CC::Engine::FileList.new(
      #       root: "/tmp",
      #       engine_config: CC::Engine::Configuration.new,
      #       linter_config: {}
      #     ).each  #=> Enumerator
      #
      #   @api public
      #   @see Array#each
      #   @return [Enumerator] an enumerator of the files in the list
      def_delegator :filtered_files, :each

      private

      # The paths to include within the root
      #
      # @api private
      # @return [Array<String>]
      attr_reader :include_paths

      # The configuration for the linters
      #
      # @api private
      # @return [HamlLint::Configuration]
      attr_reader :linter_config

      # The root path of to gather files in
      #
      # @api private
      # @return [String]
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
