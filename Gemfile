source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  #rspec-rails is a testing framework for Rails
  gem 'rspec-rails'
  #Factory Bot is a software library. That provides factory methods to create test
  # fixtures for automated software testing.
  # The fixture objects can be created on the fly;
  gem 'factory_bot_rails'
  #This gem is a port of Perl's Data::Faker library that generates fake data.
  gem 'faker', '~> 1.6', '>= 1.6.3'
  #Database Cleaner is a set of strategies for cleaning your database in Ruby.
  gem 'database_cleaner'
  #Shoulda Matchers provides RSpec- and Minitest-compatible one-liners that test common Rails functionality.
  gem 'shoulda-matchers', '~> 3.1'
  #SimpleCov is a code coverage analysis tool for Ruby.
  gem 'simplecov', require: false
  gem 'rubocop-rspec'
  gem 'rspec_api_documentation'
  gem 'guard-rspec', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'jwt'
gem 'devise'
gem 'devise-doorkeeper'
gem 'active_model_serializers'
gem 'chewy'
gem 'kaminari'
gem 'interactor'
gem 'postmark_mailer', github: 'scienceexchange/postmark_mailer'
gem 'carrierwave', '~> 1.0'
gem "fog-aws"
gem "mini_magick"
gem 'sidekiq'
gem "zendesk_api"
gem 'pundit'
gem 'parser'
gem 'unparser'
gem 'parallel'
gem 'exception_notification'
gem 'slack-notifier'

gem 'lograge'
gem 'logstash-event'
gem 'logstash-logger'
gem 'whenever', require: false
gem 'whenever-web'
gem 'haml'


group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
  gem 'capistrano3-puma', github: "seuros/capistrano-puma"
  gem 'capistrano-sidekiq', github: 'seuros/capistrano-sidekiq'
end