ENV['RACK_ENV'] = 'test'

require 'sinatra'
require 'rack/test'
require 'database_cleaner'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  
  config.before(:suite) do
    DatabaseCleaner[:active_record].strategy = :transaction
    DatabaseCleaner[:active_record].clean_with(:truncation)
  end

  config.before(:all) do
    DatabaseCleaner[:active_record].start
  end

  config.after(:all) do
    DatabaseCleaner[:active_record].clean
  end
  
end

Sinatra::Base.set :environment, :test

require File.join(File.dirname(__FILE__), '..', 'config/application.rb')

def app
  API::V1::App
end