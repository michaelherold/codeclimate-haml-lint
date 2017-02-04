require "spec_helper"
require "cc/engine/file_list"

RSpec.describe CC::Engine::FileList do
  include FileSystemHelper

  let(:engine_config) { {} }
  let(:linter_config) { HamlLint::ConfigurationLoader.default_configuration }
  let(:root) { Dir.mktmpdir }

  around(:each) do |example|
    in_directory(root) do
      example.run
    end
  end

  subject(:file_list) do
    described_class.new(
      root: root,
      engine_config: engine_config,
      linter_config: linter_config
    )
  end

  context "without any engine configuration" do
    it "uses the default include path" do
      a_path = create_source_file("a.html.haml", "%p Hello, world!")
      create_source_file("not_haml.html.erb", "<p>Hello, world!</p>")

      expect(subject.to_a).to eq([a_path])
    end

    it "doesn't include files outside the root" do
      in_directory(Dir.mktmpdir) do
        create_source_file("a.html.haml", "%p Hello, world!")
      end
      b_path = create_source_file("b.html.haml", "%p Hello, world!")

      expect(subject.to_a).to eq([b_path])
    end
  end

  context "with engine configuration" do
    let(:engine_config) { {"include_paths" => %w(src/)} }

    it "respects the engine configuration's include_paths" do
      create_source_file("a.html.haml", "%p Hello, world!")
      b_path = create_source_file("src/b.html.haml", "%p Hello, world!")

      expect(subject.to_a).to eq([b_path])
    end
  end

  context "with linter configuration" do
    let(:config_file) do
      create_source_file(".haml-lint.yml", "exclude:\n  - '**/src/b.haml'")
    end
    let(:linter_config) { HamlLint::ConfigurationLoader.load_file(config_file) }

    it "respects haml-lint.yml" do
      a_path = create_source_file("a.html.haml", "%p Hello, world!")
      create_source_file("src/b.haml", "%p Hello, world!")

      expect(subject.to_a).to eq([a_path])
    end
  end
end
