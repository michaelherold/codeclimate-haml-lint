# frozen_string_literal: true

module Fakes
  # Generates a list of two fake HamlLint::Lint objects to test againsst
  #
  # @example
  #   fake_lints
  #
  # @api public
  # @return [Array<HamlLint::Lint>]
  def fake_lints
    lines = [502, 724]
    descriptions = ['Description of lint 1', 'Description of lint 2']
    severities = %i[warning error]
    %w[some-filename.haml other-filename.haml]
      .each_with_index
      .map do |filename, index|
        fake_lint(filename, lines[index], descriptions[index], severities[index])
      end
  end

  private

  def fake_lint(filename, line, description, severity)
    HamlLint::Lint.new(
      double(name: 'SomeLinter'),
      filename,
      line,
      description,
      severity
    )
  end
end
