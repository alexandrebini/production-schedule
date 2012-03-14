require 'spork'

Spork.prefork do

  ENV['RAILS_ENV'] ||= 'test'
  require File.expand_path('../../config/environment', __FILE__)
  require 'rspec/rails'
  require 'database_cleaner'
  
  RSpec.configure do |config|
    config.mock_with :rspec

    config.before(:suite) do
      Dir.glob("#{Rails.root}/lib/**/*.rb").sort.each { |file| load file }
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
    
end

Spork.each_run do
  Fabrication.clear_definitions
end