require "fileutils"
require "haml_lint/version"

module ExtractDocumentation
  # Removes the cloned repository from the disk
  #
  # @api public
  # @return [void]
  def self.clean_up_source
    `rm -rf haml_lint-git`
  end

  # Clones the HamlLint source and checks out the current version's tag
  #
  # @api public
  # @return [void]
  def self.clone_and_check_out_source
    unless Dir.exist?("haml_lint-git")
      `git clone https://github.com/brigade/haml-lint.git haml_lint-git`
    end
    `cd haml_lint-git && git checkout tags/v#{HamlLint::VERSION}`
  end

  # Extracts the documentation from the linter README
  #
  # @api public
  # @return [Array<String>]
  def self.extract
    readme = File.read("./haml_lint-git/lib/haml_lint/linter/README.md").split("\n")
    start_keeping = false

    readme.select do |line|
      next unless start_keeping || line.start_with?("##")
      start_keeping = true
    end
  end

  # Splits the documentation up into Hashes with a filename and a body
  #
  # @api public
  # @return [Array<Hash>]
  def self.split(documentation)
    documentation_blocks = []
    in_documentation_block = false
    block = {filename: "", body: []}

    documentation.each do |line|
      if line.start_with?("## ")
        linter = line.sub(/^## /, "")
        filename = linter + ".md"
        line = "## HamlLint/#{linter}"

        if in_documentation_block
          documentation_blocks << {filename: block[:filename], body: block[:body].join("\n").rstrip}
          block = {filename: filename, body: [line]}
        else
          block[:filename] = filename
          block[:body] << line
          in_documentation_block = true
        end
      else
        if in_documentation_block
          block[:body] << line
        else
          raise "uh oh!"
        end
      end
    end

    documentation_blocks
  end


  # Writes the documentation files to the config/contents directory
  #
  # @api public
  # @return [void]
  def self.write(doc_blocks)
    path = File.expand_path(File.join(__FILE__, "..", "..", "..", "config", "contents"))
    FileUtils.mkdir_p(path)
    doc_blocks.each do |block|
      filename = File.join(path, block[:filename])
      File.write(filename, block[:body])
    end
  end
end

namespace :docs do
  desc "Scrapes documentation from the haml_lint gem"
  task :scrape do
    ExtractDocumentation.clone_and_check_out_source

    documentation = ExtractDocumentation.extract
    doc_blocks = ExtractDocumentation.split(documentation)
    ExtractDocumentation.write(doc_blocks)

    ExtractDocumentation.clean_up_source
  end
end
