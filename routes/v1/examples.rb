module API
  module V1
    class App
      
      namespace '/v1/:locale' do
        
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