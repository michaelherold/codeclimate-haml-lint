require "cc/engine/remediation_points"

RSpec.describe CC::Engine::RemediationPoints do
  let(:linter) { "AltText" }

  subject(:remediation_points) { described_class.new(linter) }

  describe "#empty?" do
    subject { remediation_points.empty? }

    it { is_expected.to eq(false) }

    context "for an unknown linter" do
      let(:linter) { "UnknownLinter" }

      it { is_expected.to eq(true) }
    end
  end

  describe "#points" do
    subject { remediation_points.points }

    it { is_expected.to eq(100_000) }

    context "for an unknown linter" do
      let(:linter) { "UnknownLinter" }

      it { is_expected.to eq(nil) }
    end
  end

  describe "#to_json" do
    subject { remediation_points.to_json }

    it { is_expected.to eq("100000") }

    context "for an unknown linter" do
      let(:linter) { "UnknownLinter" }

      it { is_expected.to eq(nil) }
    end
  end
end
