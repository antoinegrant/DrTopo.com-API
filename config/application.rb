require File.expand_path('../boot', __FILE__)

Sinatra::Base.set :environment, (ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development)

require File.expand_path('../../v1', __FILE__)