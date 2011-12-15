require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'

ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql2',
  :socket   => '/tmp/mysql.sock',
  :username => 'agrantmysql1',
  :password => 'Climbing111',
  :database => 'drtopov4',
  :encoding => 'utf8'
)

environment = (ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development)

get '/' do
  "Hello World!!! #{environment}"
end

__END__

NOTES
------------------------------
http://screencasts.org/episodes/configuring-activerecord-in-sinatra
http://devcenter.heroku.com/articles/rack
https://github.com/bmizerany/sinatra-activerecord
