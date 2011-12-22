ENV['RACK_ENV'] = 'test'

require 'sinatra'
require 'rack/test'
require 'database_cleaner'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:all) do
    DatabaseCleaner.start
  end

  config.after(:all) do
    DatabaseCleaner.clean
  end
  
end

Sinatra::Base.set :environment, :test

require File.join(File.dirname(__FILE__), '..', 'config/application.rb')

def app
  API::V1::App
end