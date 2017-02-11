require "cc/engine/haml_lint"

RSpec.describe CC::Engine::HamlLint do
  let(:engine_config) { CC::Engine::Configuration.new }
  let(:io) { StringIO.new }
  let(:root) do
    File.expand_path(
      File.join(File.expand_path(__FILE__), *Array.new(4, ".."), "examples")
    )
  end

  subject(:engine) { described_class.new(root: root, engine_config: engine_config, io: io) }

  describe "#run" do
    subject { engine.run }

    it "writes to the given IO object" do
      expect { subject }.to change(io, :string)
    end

    it "writes according to the Code Climate Spec" do
      subject
      expect(io.string).to end_with("\0")
    end
  end
end
