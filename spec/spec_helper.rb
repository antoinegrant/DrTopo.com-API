ENV['RACK_ENV'] = 'test'

require 'sinatra'
require 'rack/test'

# set test environment
set :environment, :test


RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

require File.join(File.dirname(__FILE__), '..', 'config/application.rb')

def app
  API::V1::App
end