require "cc/engine/content"

RSpec.describe CC::Engine::Content do
  let(:linter) { "AltText" }

  subject(:content) { described_class.new(linter) }

  describe "#body" do
    subject { content.body }

    it "pulls from the config/contents directory" do
      content = File.read(
        File.expand_path(
          File.join(__FILE__, "..", "..", "..", "..", "config", "contents", "#{linter}.md")
        )
      )

      expect(subject).to eq(content)
    end

    context "when it's an unknown linter" do
      let(:linter) { "DoesntExist" }

      it { is_expected.to be_nil }
    end
  end

  describe "#empty?" do
    subject { content.empty? }

    it { is_expected.to eq(false) }

    context "when it's an unknown linter" do
      let(:linter) { "DoesntExist" }

      it { is_expected.to eq(true) }
    end
  end
end
