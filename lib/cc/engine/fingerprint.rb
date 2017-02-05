require "digest/md5"

module CC
  module Engine
    # Calculates a unique fingerprint for an issue to allow for overriding
    class Fingerprint
      # Helps strip off the line counts from messages
      #
      # @api public
      # @return [Regexp]
      LINE_COUNT_STRIPPER = / \[.+\]$/

      # A list of overridable linters to calculate fingerprints for
      #
      # @api public
      # @return [Hash]
      OVERRIDABLE_LINTERS = %w(
        LineLength
        MultilineScript
        RuboCop
      ).freeze

      # Instantiates a new fingerprint
      #
      # @api public
      # @param [String] path the path of the file to fingerprint
      # @param [String] linter the name of the linter to fingerprint
      # @param [String] message the message to fingerprint
      def initialize(path, linter, message)
        @linter = linter
        @message = message
        @path = path
      end

      # Checks whether the fingerprint is empty
      #
      # @api public
      # @return [Boolean]
      def empty?
        !OVERRIDABLE_LINTERS.include?(linter)
      end

      # Converts the fingerprint to a string
      #
      # @api public
      # @return [String]
      def to_s
        unless empty?
          md5 = Digest::MD5.new
          md5 << path
          md5 << linter
          md5 << stripped_message
          md5.hexdigest
        end
      end

      private

      # The linter that generated the issue to fingerprint
      #
      # @api private
      # @return [String]
      attr_reader :linter

      # The issue message to fingerprint
      #
      # @api private
      # @return [String]
      attr_reader :message

      # The path to the file that generated the issue
      #
      # @api private
      # @return [String]
      attr_reader :path

      # A stripped version of the message
      #
      # @api priate
      # @return [String]
      def stripped_message
        message.gsub(LINE_COUNT_STRIPPER, "").strip
      end
    end
  end
end
