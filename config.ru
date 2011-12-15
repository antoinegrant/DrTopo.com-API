environment = (ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development)

Bundler.require(:default, environment)

require './v1'
run Sinatra::Application