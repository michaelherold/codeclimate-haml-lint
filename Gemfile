# frozen_string_literal: true

source "https://rubygems.org"

gem "dry-equalizer", require: false
gem "haml_lint", "~> 0.20.0", require: false
gem "parser", "~> 2.3.3.1", require: false
gem "pry", require: false

group :development do
  gem "guard-bundler"
  gem "guard-inch"
  gem "guard-rspec"
  gem "guard-rubocop"
  gem "guard-yard"
  gem "inch"
  gem "mutant-rspec", "~> 0.8"
  gem "yard", "~> 0.8"
  gem "yardstick"
end

group :ci do
  gem "codeclimate-test-reporter", require: false
  gem "simplecov", require: false
end

group :test do
  gem "rake", "< 11"
  gem "rspec"
end
