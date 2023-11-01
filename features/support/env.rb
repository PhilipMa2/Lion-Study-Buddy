# require 'simplecov'
# SimpleCov.coverage_dir('coverage/cucumber')
# SimpleCov.start do
#     add_filter 'app/channels'
#     add_filter 'app/jobs'
#     add_filter 'app/mailers'
# end

# require 'capybara/cucumber'
# require 'capybara/rspec'

# Capybara.default_driver = :selenium_chrome
# Capybara.app_host = 'http://localhost:3000'
# Capybara.run_server = false

require 'simplecov'
SimpleCov.coverage_dir('coverage/cucumber')
SimpleCov.start do
  add_filter 'app/channels'
  add_filter 'app/jobs'
  add_filter 'app/mailers'
end

require 'cucumber/rails'

ActionController::Base.allow_rescue = false

begin
    DatabaseCleaner.strategy = :transaction
rescue NameError
    raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Cucumber::Rails::Database.javascript_strategy = :truncation