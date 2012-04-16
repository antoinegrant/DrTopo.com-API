require 'json'
require File.expand_path('../lib/sinatra', __FILE__)
require File.expand_path('../models/v1', __FILE__)

module API
  module V1
    class App < API::Sinatra
      register ::Sinatra::Namespace
      
      # Simple Auth example
      # use Rack::Auth::Basic, "Restricted Area" do |username, password|
      #   [username, password] == ['admin', 'admin']
      # end
      
      before do
        ActiveRecord::Base.connection.verify!
      end
      
      namespace '/v1/:locale' do
        
        get '/?' do
          success({'data' => "Welcome to the DrTopo API!"})
        end
        
      end
      
    end
  end
end

require File.expand_path('../routes/v1/examples', __FILE__)