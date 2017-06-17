require "cc/engine/severity"

RSpec.describe CC::Engine::Severity do
  it "maps HamlLint errors to critical" do
    severity = ::HamlLint::Severity.new(:error)
    expect(described_class.from_haml_lint(severity)).to eq("minor")
  end

  it "maps HamlLint warnings to normal" do
    severity = ::HamlLint::Severity.new(:warning)
    expect(described_class.from_haml_lint(severity)).to eq("info")
  end
end
