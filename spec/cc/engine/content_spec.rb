require 'cc/engine/content'

RSpec.describe CC::Engine::Content do
  let(:linter) { 'AltText' }

  subject(:content) { described_class.new(linter) }

  describe '#body' do
    subject { content.body }

    it "is a Markdown document starting with the linter's name" do
      expect(subject.split("\n").first).to eq("## HamlLint/#{linter}")
    end

    context "when it's an unknown linter" do
      let(:linter) { 'DoesntExist' }

      it { is_expected.to be_nil }
    end
  end

  describe '#empty?' do
    subject { content.empty? }

    it { is_expected.to eq(false) }

    context "when it's an unknown linter" do
      let(:linter) { 'DoesntExist' }

      it { is_expected.to eq(true) }
    end
  end
end
