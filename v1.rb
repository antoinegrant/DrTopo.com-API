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
      
      get '/' do
        success("Welcome to the DrTopo API!")
      end
      
      get '/env' do
        success({'env' => settings.environment})
      end
      
      
      
      ####################
      # START - Examples #
      ####################
      namespace '/examples' do
        
        get '/?' do
          success(Example.find(:all))
        end
        
        post '/create' do
          halt [400,"You must specify a anme and a description."] unless params.count > 0
          begin
            Example.create!(
              :name => params[:name],
              :description => params[:description]
            )
            success
          rescue ActiveRecord::RecordInvalid => e
            failure('Could not create!','Examples:Create',400)
          end
        end
        
      end
      ##################
      # END - Examples #
      ##################
      
    end
  end
end