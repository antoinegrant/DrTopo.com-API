require 'rubygems'
require 'bundler/setup'

environment = (ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development)

Bundler.require(:default, environment)

require ::File.expand_path('../config/application',  __FILE__)
run API::V1::App