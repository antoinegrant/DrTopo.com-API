environment = (ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development)
require ::File.expand_path('../config/environment',  __FILE__)
run API::V1