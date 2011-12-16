require 'sinatra'
require 'active_record'

db_config = YAML::load(IO.read('config/database.yml'))["#{environment}"]
ActiveRecord::Base.establish_connection(
  :adapter  => db_config['adapter'],
  :host     => db_config['host'],
  :socket   => db_config['socket'],
  :username => db_config['username'],
  :password => db_config['password'],
  :database => db_config['database'],
  :encoding => db_config['encoding']
)

class Products < ActiveRecord::Base
end

before do
  ActiveRecord::Base.connection.verify!
end

get '/' do
  "Hello world! #{environment}"
  product = Products.find(:all).first
  "#{product.to_json}"
end