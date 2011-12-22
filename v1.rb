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
      
      helpers do
        def success(data={}, format='json', headers={})
          output = (data == :empty ? '' : data.to_json)
          return [200, headers, output]
        end
        def failure(message, code='', http_code=500, headers={}, backtrace=nil)
          obj = {:code => code, :message => message, :backtrace => backtrace}
          return [http_code, headers, obj.to_json]
        end
      end
      
      not_found do
        failure("The URL you are trying to access does not exists. Poop!", 'PAGE_NOT_FOUND', 404, {}, env['sinatra.error'].backtrace.join("\n"))
      end
      error do
        failure(env['sinatra.error'].message, 'ERR_UNKNOWN', 500, {}, env['sinatra.error'].backtrace.join("\n"))
      end
      
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