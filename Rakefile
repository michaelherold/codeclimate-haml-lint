# frozen_string_literal: true

Rake.add_rakelib 'lib/tasks'

def with_optional_dependency
  yield if block_given?
rescue LoadError # rubocop:disable Lint/HandleExceptions
end

with_optional_dependency do
  require 'inch/rake'
  Inch::Rake::Suggest.new(:inch)
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

with_optional_dependency do
  require 'yard/rake/yardoc_task'
  YARD::Rake::YardocTask.new(:yard)
end

with_optional_dependency do
  require 'yardstick/rake/measurement'
  options = YAML.load_file('config/yardstick.yml')
  Yardstick::Rake::Measurement.new(:yardstick_measure, options) do |measurement|
    measurement.output = 'coverage/docs.txt'
  end
end

with_optional_dependency do
  require 'yardstick/rake/verify'
  options = YAML.load_file('config/yardstick.yml')
  Yardstick::Rake::Verify.new(:yardstick_verify, options) do |verify|
    verify.threshold = 100
  end
end

task yardstick: %i[yardstick_measure yardstick_verify]

task default: %i[spec rubocop yard inch]
