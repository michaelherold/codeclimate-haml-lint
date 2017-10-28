require "haml_lint/report"
require "cc/engine/report_adapter"

RSpec.describe CC::Engine::ReportAdapter do
  include Fakes

  let(:report) { HamlLint::Report.new(lints: fake_lints, files: [], reporter: reporter) }
  let(:reporter) do
    HamlLint::Reporter::HashReporter.new(
      HamlLint::Logger.new(StringIO.new)
    )
  end

  subject(:adapter) { described_class.new(report: report, root: "") }

  describe "#to_a" do
    subject { adapter.to_a }

    it "creates an issue for each lint" do
      expect(subject.first).to eq(
        CC::Engine::Issue.new(
          linter_name: "SomeLinter",
          location: {line: 724},
          message: "Description of lint 2",
          path: "other-filename.haml",
          severity: HamlLint::Severity.new(:error)
        )
      )
      expect(subject.last).to eq(
        CC::Engine::Issue.new(
          linter_name: "SomeLinter",
          location: {line: 502},
          message: "Description of lint 1",
          path: "some-filename.haml",
          severity: HamlLint::Severity.new(:warning)
        )
      )
    end
  end
end
