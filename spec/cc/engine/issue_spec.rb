require "cc/engine/issue"
require "cc/engine/location"

RSpec.describe CC::Engine::Issue do
  let(:severity) { ::HamlLint::Severity.new(:warning) }

  subject(:offense) do
    described_class.new(
      linter_name: "HelloWorld",
      location: {line: 42},
      message: "Hello, world",
      path: "hello_world.rb",
      severity: severity
    )
  end

  describe "#check_name" do
    subject { offense.check_name }

    it { is_expected.to eq("HamlLint/HelloWorld") }
  end

  describe "#severity" do
    subject { offense.severity }

    context "when it is a warning" do
      it { is_expected.to eq("normal") }
    end

    context "when it is an error" do
      let(:severity) { ::HamlLint::Severity.new(:error) }

      it { is_expected.to eq("critical") }
    end
  end

  describe "#type" do
    subject { offense.type }

    it { is_expected.to eq("issue") }
  end
end
