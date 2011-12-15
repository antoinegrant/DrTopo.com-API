require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'

#set :database, 'mysql://agrantmysql1:Climbing111@mysq.drtopo.co/drtopov4'

ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql2',
  :socket   => '/tmp/mysql.sock',
  :username => 'agrantmysql1',
  :password => 'Climbing111',
  :database => 'drtopov4',
  :encoding => 'utf8'
)

get '/' do
  "Hello World!!!"
end

__END__

NOTES
------------------------------
http://screencasts.org/episodes/configuring-activerecord-in-sinatra
http://devcenter.heroku.com/articles/rack
https://github.com/bmizerany/sinatra-activerecord
