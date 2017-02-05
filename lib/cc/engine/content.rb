module CC
  module Engine
    # Pulls data from our database of suggestions for a linter
    class Content
      # Instantiates a piece of content for a linter
      #
      # @api public
      # @param [String] linter the linter to read content for
      def initialize(linter)
        @linter = linter
      end

      # The linter to read content for
      #
      # @api public
      # @return [String]
      attr_reader :linter

      # The suggestions for how to fix a given piece of lint
      #
      # @api public
      # @return [String, NilClass]
      def body
        @body ||= (File.exist?(content_path) && File.read(content_path)) || nil
      end

      def empty?
        !body.nil?
      end

      private

      # The path to the content file
      #
      # @api private
      # @return [String]
      def content_path
        @content_path ||=
          File.expand_path(
            File.join(__FILE__, "..", "..", "..", "..", "config", "contents", "#{linter}.md")
          )
      end
    end
  end
end
