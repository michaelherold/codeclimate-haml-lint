module Fakes
  # Generates a list of two fake HamlLint::Lint objects to test againsst
  #
  # @return [Array<HamlLint::Lint>]
  def fake_lints
    lines = [502, 724]
    descriptions = ["Description of lint 1", "Description of lint 2"]
    severities = %i(warning error)
    %w(some-filename.haml other-filename.haml).
      each_with_index.
      map do |filename, index|
        HamlLint::Lint.new(
          double(name: "SomeLinter"),
          filename,
          lines[index],
          descriptions[index],
          severities[index]
        )
      end
  end
end
