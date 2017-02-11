module FileSystemHelper
  # Creates a file with content at a specific path
  #
  # @example
  #   a_path = create_source_file("a.haml", "%p Hello, world!")
  #
  # @api public
  # @param [String] path the path to the file
  # @param [String] content the content of the file
  # @return [String] the real path to the written file
  def create_source_file(path, content)
    absolute_path = File.join(Dir.pwd, path)
    FileUtils.mkdir_p(File.dirname(absolute_path))
    File.write(absolute_path, content)

    Pathname.new(path).realpath.to_s
  end

  # Performs a block within the context of a root directory
  #
  # @example
  #   in_directory("/tmp") do
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
