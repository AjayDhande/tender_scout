# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'simplecov'
SimpleCov.start do
  add_group 'API Controllers', 'app/controllers/v1'
  add_group 'API Models',      'app/models'
end
# require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'support/database_cleaner'
require 'shoulda/matchers'
require 'support/factory_bot'
require 'support/api_helpers'
require 'devise'
require 'support/controller_macros'
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # shared context
  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # config.use_transactional_fixtures = true

  #other
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include ApiHelpers
  config.extend ControllerMacros, type: :controller
end

# Shoulda configuration
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec
    # Choose one or more libraries:
    with.library :rails
  end
end
