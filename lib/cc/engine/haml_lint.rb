# frozen_string_literal: true

require "json"
require "haml_lint"
require "haml_lint/configuration_loader"
require "cc/engine/configuration"
require "cc/engine/file_list"
require "cc/engine/source_file"

module CC
  module Engine
    # Lints files in the Code Climate format
    class HamlLint
      # Instantiates a new HamlLint engine
      #
      # @api public
      # @param [String] root the root directory to analyze from
      # @param [CC::Engine::Configuration] engine_config the engine configuration
      # @param [IO] io the IO to write results to
      # @return [CC::Engine::HamlLint]
      def initialize(root:, engine_config:, io:)
        @engine_config = engine_config || CC::Engine::Configuration.new
        @io = io
        @root = root
      end

      # Lints files based on the engine configuration
      #
      # @api public
      # @return [void]
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

      # The engine configuration
      #
      # @api private
      # @return [CC::Engine::Configuration]
      attr_reader :engine_config

      # The output IO
      #
      # @api private
      # @return [IO]
      attr_reader :io

      # The root directory in which to analyze files
      #
      # @api private
      # @return [String]
      attr_reader :root

      # The base configuration to pass to HamlLint
      #
      # @api private
      # @return [HamlLint::Configuration]
      def base_config
        if engine_config.config
          ::HamlLint::ConfigurationLoader.load_file(engine_config.config)
        else
          ::HamlLint::ConfigurationLoader.default_configuration
        end
      end

      # The list of files to analyze based on the engine configuration
      #
      # @api private
      # @return [CC::Engine::FileList]
      def files_to_inspect
        @files_to_inspect ||= FileList.new(
          root: root,
          engine_config: engine_config,
          linter_config: linter_config
        )
      end

      # The configuration to pass to HamlLint
      #
      # @api private
      # @return [HamlLint::Configuration]
      def linter_config
        @linter_config ||= base_config.merge(engine_config.to_linter_config)
      end
    end
  end
end
