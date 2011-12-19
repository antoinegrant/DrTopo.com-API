require File.expand_path('../boot', __FILE__)

require 'sinatra'
require 'sinatra/base'
require 'sinatra/namespace'
require 'active_record'
require 'json'

set :environment, (ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development)

require File.expand_path('../../V1', __FILE__)