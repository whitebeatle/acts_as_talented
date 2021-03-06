ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl_rails'
require 'pry'
require 'shoulda-matchers'
# require 'protected_attributes'
require "codeclimate-test-reporter"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.order = "random"
  config.include Devise::TestHelpers, :type => :controller

  require 'database_cleaner'

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    DatabaseCleaner.start
  end

  config.after(:each) do |example|
    DatabaseCleaner.clean
  end

  config.include Rails.application.routes.url_helpers
  config.include ActsAsTalented::Engine.routes.url_helpers

end