require 'sinatra'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql2',
  :host     => 'mysql.drtopo.com',
  :username => 'agrantmysql1',
  :password => 'Climbing111',
  :database => 'drtopov4',
  :encoding => 'utf8'
)

get '/' do
  "Hello world!"
end