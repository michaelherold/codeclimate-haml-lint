# frozen_string_literal: true

source "https://rubygems.org"

gem "dry-equalizer", require: false
gem "haml_lint", "0.23.2"
gem "parser", "~> 2.3.3.1", require: false

# RuboCop plugins
gem "rubocop-rspec", require: false

group :development do
  gem "guard-bundler"
  gem "guard-inch"
  gem "guard-rspec"
  gem "guard-rubocop"
  gem "guard-yard"
  gem "mutant-rspec", "~> 0.8"
  gem "pry", require: false
end

group :ci do
  gem "codeclimate-test-reporter", require: false
  gem "inch", require: false
  gem "simplecov", require: false
  gem "yard", "~> 0.8", require: false
  gem "yardstick", require: false
end

group :test do
  gem "rake", "< 11"
  gem "rspec"
end
