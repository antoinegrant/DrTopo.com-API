require File.expand_path('../boot', __FILE__)

require 'sinatra'
require 'active_record'
require 'json'

set :environment, (ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development)

db_config = YAML::load(IO.read('config/database.yml'))["#{settings.environment}"]
ActiveRecord::Base.establish_connection(
  :adapter  => db_config['adapter'],
  :host     => db_config['host'],
  :socket   => db_config['socket'],
  :username => db_config['username'],
  :password => db_config['password'],
  :database => db_config['database'],
  :encoding => db_config['encoding']
)

require File.expand_path('../../V1', __FILE__)