require 'sinatra/base'
require File.expand_path('../models/v1', __FILE__)

module API
  module V1
    class App < Sinatra::Base
      
      configure do
        ActiveRecord::Base.configurations = YAML::load(IO.read('config/database.yml'))
        ActiveRecord::Base.establish_connection(settings.environment)
      end
      
      before do
        ActiveRecord::Base.connection.verify!
      end
      
      get '/' do
        "Welcome to the DrTopo API!"
      end
      
      get '/env' do
        {'env' => settings.environment}.to_json
      end
      
    end
  end
end