# frozen_string_literal: true

require "json"
require "haml_lint"
require "haml_lint/configuration_loader"
require "cc/engine/file_list"
require "cc/engine/source_file"

module CC
  module Engine
    class HamlLint
      def initialize(root:, engine_config:, io:)
        @engine_config = engine_config || {}
        @io = io
        @root = root
      end

      def run
        files_to_inspect.each do |path|
          SourceFile.new(
            linter_config: linter_config,
            io: io,
            path: path,
            root: root
          ).process
        end
      end

      private

      attr_reader :engine_config
      attr_reader :io
      attr_reader :root

      def files_to_inspect
        @files_to_inspect || FileList.new(
          root: root,
          include_paths: engine_config["include_paths"]
        )
      end

      def linter_config
        @linter_config ||= HamlLint::ConfigurationLoader.default_configuration
      end
    end
  end
end
