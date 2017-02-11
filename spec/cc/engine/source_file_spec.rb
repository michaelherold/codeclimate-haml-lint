require "stringio"
require "cc/engine/source_file"

RSpec.describe CC::Engine::SourceFile do
  include FileSystemHelper

  let(:io) { StringIO.new }
  let(:linter_config) { HamlLint::ConfigurationLoader.default_configuration }
  let(:root) { Dir.mktmpdir }

  around(:each) do |example|
    in_directory(root) do
      example.run
    end
  end

  subject(:source_file) do
    described_class.new(
      io: io,
      linter_config: linter_config,
      path: path,
      root: root
    )
  end

  describe "#path" do
    let(:path) { create_source_file("a.haml", "%p Hello, world!") }

    subject { source_file.path }

    it { is_expected.to eq("a.haml") }
  end

  describe "#process" do
    let(:path) do
      create_source_file("a.haml", %(%p{ id: "hello"} Hello, world!))
    end

    subject { source_file.process }

    it "writes to the IO object" do
      subject

      output = io.string

      expect(output).to end_with("\0")
    end
  end
end
