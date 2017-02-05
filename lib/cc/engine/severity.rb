require "delegate"

module CC
  module Engine
    class Severity < SimpleDelegator
      # Maps the HamlLint severity to the Code Climate termoinology.
      #
      # @api private
      # @return [Hash]
      HAML_LINT_TO_CODE_CLIMATE = {
        "error" => "critical",
        "warning" => "normal",
      }.freeze

      # Converts the HamlLint severity ontology into the Code Climate one
      #
      # @api public
      # @param [String] severity the severity of the issue in HamlLint ontology
      # @return [String]
      def self.from_haml_lint(severity)
        new(HAML_LINT_TO_CODE_CLIMATE[severity] || "info")
      end
    end
  end
end
