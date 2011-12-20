require 'sinatra/base'
require File.expand_path('../models/product', __FILE__)

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
        product = API::V1::Product.find(:all).first
        product.to_json
      end
    
      get '/env' do
        {'env' => settings.environment}.to_json
      end
    
    end
  end
end