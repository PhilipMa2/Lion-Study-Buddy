require 'capybara/cucumber'
require 'capybara/rspec'

Capybara.default_driver = :selenium_chrome
Capybara.app_host = 'http://localhost:3000'
Capybara.run_server = false