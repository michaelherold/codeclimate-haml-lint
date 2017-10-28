module CC
  module Engine
    # Pulls data from our database of suggestions for a linter
    class Content
      # Instantiates a piece of content for a linter
      #
      # @example
      #   CC::Engine::Content.new("AltText")
      #
      # @api public
      # @param [String] linter the linter to read content for
      def initialize(linter)
        @linter = linter
      end

      # The linter to read content for
      #
      # @example
      #   CC::Engine::Content.new("AltText").linter  #=> "AltText"
      #
      # @api public
      # @return [String]
      attr_reader :linter

      # The suggestions for how to fix a given piece of lint
      #
      # @example
      #   CC::Engine::Content.new("AltText").body  #=> "..."
      #
      # @api public
      # @return [String, NilClass]
      def body
        @body ||= (File.exist?(content_path) && File.read(content_path)) || nil
      end

      # Checks whether the content is empty
      #
      # @example
      #   CC::Engine::Content.new("AltText").empty?  #=> false
      #
      # @api public
      # @return [Boolean]
      def empty?
        !body
      end

      # Converts the contents into a Hash
      #
      # @example
      #   CC::Engine::Content.new("AltText").to_h  #=> {body: "..."}
      #
      # @api public
      # @return [Hash]
      def to_h
        { body: body }
      end

      # Converts the contents into a JSON document
      #
      # @example
      #   CC::Engine::Content.new("AltText").to_h  #=> '{"body": '...'}"
      #
      # @api public
      # @return [String] the contents matching the Code Climate spec for contents
      def to_json(*args)
        to_h.to_json(*args)
      end

      private

      # The path to the content file
      #
      # @api private
      # @return [String]
      def content_path
        @content_path ||=
          File.expand_path(
            File.join(__FILE__, '..', '..', '..', '..', 'config', 'contents', "#{linter}.md")
          )
      end
    end
  end
end
