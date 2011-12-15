require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'

db_config = YAML::load(IO.read('config/database.yml'))[environment]

ActiveRecord::Base.establish_connection(
  :adapter  => db_config['adapter'],
  :socket   => db_config['socket'],
  :username => db_config['username'],
  :password => db_config['password'],
  :database => db_config['database'],
  :encoding => db_config['encoding']
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
