require 'rubygems'
require 'bundler/setup'

environment = (ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development)

Bundler.require(:default, environment)

require './config/application'
run API::V1