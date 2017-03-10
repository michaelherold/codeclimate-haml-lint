module FileSystemHelper
  # Creates a path to the given example directory.
  #
  # @example
  #   examples_path("file_list")
  #
  # @api public
  # @param [String] directory the subdirectory within support/examples
  # @return [String] the full path to the directory
  def examples_path(directory)
    File.expand_path(File.join(__FILE__, "..", "..", "examples", directory))
  end

  # Creates a path to the given example file within the current directory.
  #
  # @example
  #   in_directory(examples_path("file_list")) do
  #     a_path = example_file("a.html.haml")
  #   end
  #
  # @api public
  # @param [String] file_name the name of the example file
  # @return [String] the full path to the example file
  def example_file(file_name)
    Pathname.new(File.join(Dir.pwd, file_name)).to_s
  end

  # Performs a block within the context of a root directory
  #
  # @example
  #   in_directory(examples_path("file_list")) do
  #     create_source_file("a.haml", "%p Hello, world!")
  #   end
  #
  # @api public
  # @param [String] root the directory to change to
  # @param [Block] _block the block to perform
  # @return [void]
  def in_directory(root, &_block)
    Dir.chdir(root) { yield }
  end
end
