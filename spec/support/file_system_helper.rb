module FileSystemHelper
  def create_source_file(path, content)
    absolute_path = File.join(Dir.pwd, path)
    FileUtils.mkdir_p(File.dirname(absolute_path))
    File.write(absolute_path, content)

    Pathname.new(path).realpath.to_s
  end

  def in_directory(root)
    Dir.chdir(root) { yield }
  end
end
