require "forwardable"
require "json"
require "stringio"
require "haml_lint/logger"
require "cc/engine/issue"

module CC
  module Engine
    # Converts the +HamlLint+ report format to CodeClimate issues
    class ReportAdapter
      extend Forwardable
      include Enumerable

      # Instantiates a new report adapter
      #
      # @param [HamlLint::Report] report the report to adapt to CodeClimate
      # @param [String] root the root path for the report
      def initialize(report:, root:)
        @report = report
        @root = root
      end

      def_delegators :issues, :each

      private

      # The report to convert
      #
      # @api private
      # @return [HamlLint::Report]
      attr_reader :report

      # The root for the analysis
      #
      # @api private
      # @return [String]
      attr_reader :root

      # Creates all of the issues for a particular report analysis
      #
      # @api private
      # @param [Hash] analysis the Hash of report analysis results
      # @return [Array<CC::Engine::Issue>]
      def create_issues_from(analysis)
        analysis[:offenses].map do |offense|
          Issue.new(offense.merge(path: analysis[:path], root: root))
        end
      end

      # Instantiates the logger to use in the report
      #
      # @api private
      # @param [IO] io the output for the +HamlLint::Logger+
      # @return [HamlLint::Logger]
      def log(io)
        ::HamlLint::Logger.new(io)
      end

      # Converts the HamlLint JSON output to a list of issues
      #
      # @api private
      # @return [Array<CC::Engine::Issue>]
      def issues
        @offenses ||=
          JSON.parse(output, symbolize_names: true).
          fetch(:files, []).
          flat_map { |file| create_issues_from(file) }
      end

      # Captures the output from the HamlLint reporter
      #
      # @api private
      # @return [String]
      def output
        @output ||=
          begin
            output = StringIO.new
            print_report(output)
            output.string
          end
      end

      # Prints the report to the given IO
      #
      # @api private
      # @param [IO] io the output for the +HamlLint::Reporter::JsonReporter+
      # @return [void]
      def print_report(io)
        reporter(io).display_report(report)
      end

      # Instantiates the reporter to generate the HamlLint report
      #
      # @api private
      # @param [IO] io the output for the +HamlLint::Reporter::JsonReporter+
      # @return [HamlLint::Reporter::JsonReporter]
      def reporter(io)
        ::HamlLint::Reporter::JsonReporter.new(log(io))
      end
    end
  end
end
