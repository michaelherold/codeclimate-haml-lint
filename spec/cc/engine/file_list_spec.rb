require "spec_helper"
require "cc/engine/file_list"

RSpec.describe CC::Engine::FileList do
  include FileSystemHelper

  let(:engine_config) { CC::Engine::Configuration.new }
  let(:linter_config) { HamlLint::ConfigurationLoader.default_configuration }
  let(:root) { examples_path("file_list") }

  around(:each) do |example|
    in_directory(root) do
      example.run
    end
  end

  let(:file_list) do
    described_class.new(
      root: root,
      engine_config: engine_config,
      linter_config: linter_config
    )
  end

  subject(:file_names) { file_list.to_a }

  context "without any engine configuration" do
    it "uses the default include path" do
      a_path = example_file("a.html.haml")
      not_haml_path = example_file("not_haml.html.erb")

      expect(subject).to include(a_path)
      expect(subject).not_to include(not_haml_path)
    end
  end

  context "with engine configuration" do
    let(:engine_config) { CC::Engine::Configuration.new("include_paths" => %w(src/)) }

    it "respects the engine configuration's include_paths" do
      a_path = example_file("a.html.haml")
      b_path = example_file("src/b.html.haml")

      expect(subject).to include(b_path)
      expect(subject).not_to include(a_path)
    end

    context "that has a single file as its include_paths" do
      let(:engine_config) { CC::Engine::Configuration.new("include_paths" => %w(src/b.html.haml)) }

      it "respects the engine configuration's include_paths" do
        a_path = example_file("a.html.haml")
        b_path = example_file("src/b.html.haml")

        expect(subject).to include(b_path)
        expect(subject).not_to include(a_path)
      end
    end

    context "that has both include_paths and exclude_paths" do
      let(:engine_config) do
        CC::Engine::Configuration.new(
          "exclude_paths" => %w(src/b.html.haml),
          "include_paths" => %w(src/)
        )
      end

      it "prefers the exclude_paths" do
        a_path = example_file("a.html.haml")
        b_path = example_file("src/b.html.haml")

        expect(subject).not_to include(b_path)
        expect(subject).not_to include(a_path)
      end
    end
  end

  context "with linter configuration" do
    let(:config_file) { example_file(".haml-lint.yml") }
    let(:linter_config) { HamlLint::ConfigurationLoader.load_file(config_file) }
    let(:root) { examples_path("file_list_with_config") }

    it "respects haml-lint.yml" do
      a_path = example_file("a.html.haml")
      b_path = example_file("src/b.haml")

      expect(subject).to include(a_path)
      expect(subject).not_to include(b_path)
    end
  end
end
