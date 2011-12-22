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
      
      get '/' do
        success("Welcome to the DrTopo API!")
      end
      
      
      ####################
      # START - Examples #
      ####################
      namespace '/examples' do
        
        # Multiple path for the same method
        ['/?','/all'].each do |path|
          get path do
            success(Example.find(:all))
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
            failure('Could not create!','EXAMPLES_CREATE',400)
          end
        end
        
        get '/:id' do
          begin
            success(Example.find(params[:id]).attributes)
          rescue ActiveRecord::RecordNotFound => e
            failure("Could not find the post id: #{params[:id]}",'EXAMPLES_SHOW',400)
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
            failure('Could not create!','EXAMPLES_UPDATE',400)
          end
        end
        
        get '/delete/:id' do
          begin
            Example.destroy(params[:id])
            success
          rescue Exception => e
            failure("Not item found with the id: #{params[:id]}",'EXAMPLES_DELETE',400)
          end
        end
        
      end
      ##################
      # END - Examples #
      ##################
      
    end
  end
end