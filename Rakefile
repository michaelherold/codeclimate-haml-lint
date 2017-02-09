require "inch/rake"
require "rspec/core/rake_task"
require "rubocop/rake_task"
require "yard/rake/yardoc_task"
require "yardstick/rake/measurement"
require "yardstick/rake/verify"

Rake.add_rakelib "lib/tasks"

Inch::Rake::Suggest.new(:inch)

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

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:rubocop)
YARD::Rake::YardocTask.new(:yard)

Yardstick::Rake::Measurement.new(:yardstick_measure) do |measurement|
  measurement.output = "coverage/docs.txt"
end

Yardstick::Rake::Verify.new(:yardstick_verify) do |verify|
  verify.threshold = 100
end

task yardstick: %i(yardstick_measure yardstick_verify)

task default: %i(spec rubocop yard inch)
