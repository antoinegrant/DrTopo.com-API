require 'sinatra/base'
require 'sinatra/namespace'
require File.expand_path('../models/v1', __FILE__)

module API
  module V1
    class App < Sinatra::Base
      register ::Sinatra::Namespace
      
      # Simple Auth example
      # use Rack::Auth::Basic, "Restricted Area" do |username, password|
      #   [username, password] == ['admin', 'admin']
      # end
      
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
      
      
      
      ####################
      # START - Examples #
      ####################
      namespace '/examples' do
        
        get '/?' do
          Example.find(:all).to_json
        end
        
        get '/create' do
          halt [400,"You must specify a anme and a description."] unless params.count > 0
          begin
            Example.create!(
              :name => params[:name],
              :description => params[:description]
            )
            return [200,"ok"]
          rescue ActiveRecord::RecordInvalid => e
            return [400,e.to_json]
          end
        end
        
      end
      ##################
      # END - Examples #
      ##################
      
    end
  end
end