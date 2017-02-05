require "cc/engine/severity"

RSpec.describe CC::Engine::Severity do
  it "maps HamlLint errors to critical" do
    expect(described_class.from_haml_lint("error")).to eq("critical")
  end

  it "maps HamlLint warnings to normal" do
    expect(described_class.from_haml_lint("warning")).to eq("normal")
  end
end
