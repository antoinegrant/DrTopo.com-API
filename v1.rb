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
      
      namespace '/v1' do
        
        get '/?' do
          success({'data' => "Welcome to the DrTopo API!"})
        end
        
        
        ####################
        # START - Examples #
        ####################
        namespace '/examples' do
          
          # Multiple path for the same method
          ['/?','/all'].each do |path|
            get path do
              success({'data' => Example.find(:all)})
            end
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
              failure({'message' => 'Could not create!', 'code' => 'EXAMPLES_CREATE', 'http_code' => 400})
            end
          end
          
          get '/show/:id' do
            begin
              post = Example.find(params[:id])
              success({'data' => post})
            rescue ActiveRecord::RecordNotFound => e
              failure({'message' => "Could not find the post id: #{params[:id]}", 'code' => 'EXAMPLES_SHOW', 'http_code' => 400})
            end
          end
          
          post '/update/:id' do
            begin
              Example.update(
                params[:id],
                :name => params[:name],
                :description => params[:description]
              )
              success
            rescue Exception => e
              failure({'message' => 'Could not create!', 'code' => 'EXAMPLES_UPDATE', 'http_code' => 400})
            end
          end
          
          get '/delete/:id' do
            begin
              Example.destroy(params[:id])
              success
            rescue Exception => e
              failure({'message' => "Not item found with the id: #{params[:id]}", 'code' => 'EXAMPLES_DELETE', 'http_code' => 400})
            end
          end
          
        end
        ##################
        # END - Examples #
        ##################
        
      end
      
    end
  end
end