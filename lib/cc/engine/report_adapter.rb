require 'forwardable'
require 'json'
require 'stringio'
require 'haml_lint/logger'
require 'cc/engine/issue'

module CC
  module Engine
    # Converts the +HamlLint+ report format to CodeClimate issues
    class ReportAdapter
      extend Forwardable
      include Enumerable

      # Instantiates a new report adapter
      #
      # @example
      #   CC::Engine::ReportAdapter.new(
      #     report: HamlLint::Report.new([], %w(a.haml)),
      #     root: "/tmp"
      #   )
      #
      # @api public
      # @param [HamlLint::Report] report the report to adapt to CodeClimate
      # @param [String] root the root path for the report
      def initialize(report:, root:)
        @report = report
        @root = root
      end

      # @!method each
      #   Enumerates through the issues in a report
      #
      #   @example
      #     adapter = CC::Engine::ReportAdapter.new(
      #       report: HamlLint::Report.new([], %w(a.haml)),
      #       root: "/tmp"
      #     )
      #
      #     adapter.each { |issue| puts issue }
      #
      #   @api public
      #   @see Array#each
      #   @return [Enumerator] an enumerator of the issues in the report
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

      # Converts the HamlLint JSON output to a list of issues
      #
      # @api private
      # @return [Array<CC::Engine::Issue>]
      def issues
        @issues ||=
          output
          .fetch(:files, [])
          .flat_map { |file| create_issues_from(file) }
      end

      # Captures the output from the HamlLint reporter
      #
      # @api private
      # @return [String]
      def output
        @output ||= report.display
      end
    end
  end
end
