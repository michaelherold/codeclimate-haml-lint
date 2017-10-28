# frozen_string_literal: true

require 'dry-equalizer'

module CC
  module Engine
    # Represents a location in a source file
    class Location
      include Dry::Equalizer(:line, :path)

      # Converts from the HamlLint location storage to Code Climate format
      #
      # @example
      #   CC::Engine::Location.from_haml_lint(
      #     location: {line: 42}
      #     path: "a.haml",
      #     root: "/tmp"
      #   )
      #
      # @api public
      # @param [Hash] location a Hash with a :line key
      # @param [String] path the absolute path to the file
      # @param [String] root the root path for the file
      # @return [CC::Engine::Location]
      def self.from_haml_lint(location:, path:, root:)
        root = Pathname.new(root).realpath.to_s
        new(line: location[:line], path: path.sub(%r{^#{root}/}, ''))
      end

      # Instantiates a new location
      #
      # @example
      #   CC::Engine::Location.new(line: 42, path: "a.haml")
      #
      # @api public
      # @param [Integer] line the line number in the file
      # @param [String] path the absolute path to the file
      def initialize(line:, path:)
        @line = line
        @path = path
      end

      # The line in the file
      #
      # @example
      #   location = CC::Engine::Location.new(line: 42, path: "a.haml")
      #   location.line  #=> 42
      #
      # @api public
      # @return [Integer]
      attr_reader :line

      # The absolute path to the file
      #
      # @example
      #   location = CC::Engine::Location.new(line: 42, path: "a.haml")
      #   location.path  #=> "a.haml"
      #
      # @api public
      # @return [String]
      attr_reader :path

      # Converts the location to the Code Climate hash format
      #
      # @example
      #   location = CC::Engine::Location.new(line: 42, path: "a.haml")
      #   location.to_h  #=> {path: "a.haml", lines: {begin: 42, end: 42}}
      #
      # @api public
      # @return [Hash]
      def to_h
        {}.tap do |hash|
          hash[:path] = path
          hash[:lines] = {}.tap do |lines|
            lines[:begin] = line
            lines[:end] = line
          end
        end
      end

      # Converts the location to the Code Climate JSON format
      #
      # @example
      #   location = CC::Engine::Location.new(line: 42, path: "a.haml")
      #   location.to_json  #=> '{"path": "a.haml", "lines": {"begin": 42, "end": 42"}}'
      #
      # @api public
      # @return [String] a JSON document of the location
      def to_json(*args)
        to_h.to_json(*args)
      end
    end
  end
end
