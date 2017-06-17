require "cc/engine/categories"

RSpec.describe CC::Engine::Categories do
  let(:linter) { "AltText" }

  subject(:categories) { described_class.new(linter) }

  it "is exhaustive of all linters" do
    HamlLint::LinterRegistry.
      linters.
      map { |klass| klass.to_s.split("::").last }.
      each do |linter|
        expect(described_class::CATEGORIES).to have_key(linter)
      end
  end

  describe "#to_json" do
    subject { categories.to_json }

    it { is_expected.to eq('["Compatibility"]') }

    context "for an unknown linter" do
      let(:linter) { "UnknownLinter" }

      it { is_expected.to eq('["Style"]') }
    end
  end
end
