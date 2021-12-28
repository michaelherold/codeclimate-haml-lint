# frozen_string_literal: true

source 'https://rubygems.org'

ruby File.read('.ruby-version')

gem 'dry-equalizer', require: false
gem 'haml_lint', '0.33.0'
gem 'parser', '~> 2.5.1.0', require: false

# RuboCop plugins
gem 'rubocop-performance', require: false
gem 'rubocop-rspec', require: false

group :development do
  gem 'guard-bundler'
  gem 'guard-inch'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'guard-yard'
  gem 'pry', require: false
end

group :test do
  gem 'codeclimate-test-reporter', require: false
  gem 'inch', require: false
  gem 'rake', '>= 12.3.3'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'yard', '~> 0.9', require: false
  gem 'yardstick', require: false
end
