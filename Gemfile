# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.8'
gem 'redis', '~> 4.0'

gem 'active_model_serializers'
gem 'bcrypt', '~> 3.1.7'
gem 'dotenv-rails'
gem 'faraday'
gem 'jwt'
gem 'pundit'
gem 'rack-cors'
gem 'ransack'
gem 'rolify'

gem 'pagy'

gem 'rswag-api'
gem 'rswag-ui'

gem 'bootsnap', require: false
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'rswag-specs'

  # Security tools
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'ruby_audit'

  # Linting tools
  gem 'rubocop'
  gem 'rubocop-rails'
end

group :test do
  gem 'shoulda-matchers', '~> 4.5', '>= 4.5.1'
  # mock api web requests
  gem 'webmock'
end

group :development do
end