require "haml_lint/reporter"
require "haml_lint/reporter/json_reporter"
require "cc/engine/issue"
require "cc/engine/report_adapter"

module CC
  module Engine
    # Encapsulates a source file to be analyzed by HamlLint
    class SourceFile
      # Instantiates a new source file
      #
      # @example
      #   CC::Engine::SourceFile.new(
      #     io: StringIO.new,
      #     linter_config: ::HamlLint::ConfigurationLoader.default_configuration,
      #     path: "a.haml",
      #     root: "/tmp"
      #   )
      #
      # @api public
      # @param [IO] io the IO object to output the analysis to
      # @param [HamlLint::Configuration] linter_config the configuration for the HamlLint linters
      # @param [String] path the absolute path to the file to analyze
      # @param [String] root the root path of the file to analyze
      def initialize(io:, linter_config:, path:, root:)
        @io = io
        @linter_config = linter_config
        @full_path = path
        @root = root
      end

      # The relative path to the file
      #
      # @example
      #   source_file = CC::Engine::SourceFile.new(
      #     io: StringIO.new,
      #     linter_config: ::HamlLint::ConfigurationLoader.default_configuration,
      #     path: "a.haml",
      #     root: "/tmp"
      #   )
      #   source_file.path #=> "a.haml"
      #
      # @api public
      # @return [String]
      def path
        real_path = Pathname.new(root).realpath.to_s
        full_path.sub(%r{^#{real_path}/}, "")
      end

      # Processes the file with HamlLint and outputs to the configured IO
      #
      # @example
      #   source_file = CC::Engine::SourceFile.new(
      #     io: StringIO.new,
      #     linter_config: ::HamlLint::ConfigurationLoader.default_configuration,
      #     path: "a.haml",
      #     root: "/tmp"
      #   )
      #   source_file.process
      #
      # @api public
      # @return [void]
      def process
        ReportAdapter.new(report: runner.run(run_options), root: root).each do |issue|
          io.print issue.to_json
          io.print "\0"
        end
      end

      private

      # The IO to write the result of the analysis to
      #
      # @api private
      # @return [IO]
      attr_reader :io

      # The HamlLint linter configuration to analyze with
      #
      # @api private
      # @return [HamlLint::Configuration]
      attr_reader :linter_config

      # The full path to the file to analyze
      #
      # @api private
      # @return [String[
      attr_reader :full_path

      # The root path to the file to analyze
      #
      # @api private
      # @return [String]
      attr_reader :root

      # Instantiates the reporter to generate the HamlLint report
      #
      # @api private
      # @return [HamlLint::Reporter::HashReporter]
      def reporter
        @reporter ||= ::HamlLint::Reporter::HashReporter.new(
          ::HamlLint::Logger.new(StringIO.new)
        )
      end

      # The options to pass to the HamlLint runner
      #
      # @api private
      # @return [Hash]
      def run_options
        {
          config: linter_config,
          excluded_linters: [],
          files: [full_path],
          included_linters: linter_config["linters"].keys,
          reporter: reporter,
        }
      end

      # The runner to use for analyzing the source file
      #
      # @api private
      # @return [HamlLint::Runner]
      def runner
        @runner ||= ::HamlLint::Runner.new
      end
    end
  end
end
