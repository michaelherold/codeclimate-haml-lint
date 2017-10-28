require 'delegate'

module CC
  module Engine
    # Converts the HamlLint severity terms to the Code Climate equivalents
    class Severity < SimpleDelegator
      # Maps the HamlLint severity to the Code Climate termoinology
      #
      # @api private
      # @return [Hash]
      HAML_LINT_TO_CODE_CLIMATE = {
        error: 'minor',
        warning: 'info'
      }.freeze

      # Converts the HamlLint severity ontology into the Code Climate one
      #
      # @example
      #   CC::Engine::Severity.from_haml_lint("error")
      #
      # @api public
      # @param [String] severity the severity of the issue in HamlLint ontology
      # @return [String]
      def self.from_haml_lint(severity)
        new(HAML_LINT_TO_CODE_CLIMATE[severity.name] || 'info')
      end
    end
  end
end
