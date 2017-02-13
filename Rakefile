Rake.add_rakelib "lib/tasks"

begin
  require "inch/rake"
  Inch::Rake::Suggest.new(:inch)
rescue LoadError
end

task :mutant do
  command = [
    "bundle exec mutant",
    "--include lib",
    "--require cc/engine/haml_lint",
    "--use rspec",
    "CC::Engine*",
  ].join(" ")

  system command
end

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"
RuboCop::RakeTask.new(:rubocop)

begin
  require "yard/rake/yardoc_task"
  YARD::Rake::YardocTask.new(:yard)
rescue LoadError
end

begin
  require "yardstick/rake/measurement"
  options = YAML.load_file("config/yardstick.yml")
  Yardstick::Rake::Measurement.new(:yardstick_measure, options) do |measurement|
    measurement.output = "coverage/docs.txt"
  end
rescue LoadError
end

begin
  require "yardstick/rake/verify"
  options = YAML.load_file("config/yardstick.yml")
  Yardstick::Rake::Verify.new(:yardstick_verify, options) do |verify|
    verify.threshold = 100
  end
rescue LoadError
end

task yardstick: %i(yardstick_measure yardstick_verify)

task default: %i(spec rubocop yard inch)
