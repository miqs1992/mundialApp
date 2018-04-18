source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.6'
gem 'dotenv-rails', groups: [:development, :test]
gem "passenger", ">= 5.0.25", require: "phusion_passenger/rack_handler"
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
# gem 'redis', '~> 3.0'
gem 'pg', '~> 0.21'
gem 'devise'
gem 'bootsnap', require: false
gem 'kaminari'
gem 'coveralls', require: false
gem 'premailer-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.18'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'rspec-rails', '~> 3.7'
  gem 'factory_bot_rails', '~> 4.8.2'
  gem 'faker'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'puma'
  gem 'launchy', '~> 2.4.3'
  gem 'shoulda-matchers', :github => 'thoughtbot/shoulda-matchers', :branch => 'master' 
end

