require 'spec_helper'

describe 'The API should,' do
  
  context 'start and' do
    
    it 'get the home page' do
      get '/'
      last_response.status.should == 200
    end
    
    it 'be in test mode' do
      get '/env'
      JSON.parse(last_response.body)['env'].should == 'test'
    end
    
    
    ####################
    # START - Examples #
    ####################
    context 'test the examples,' do
      
      it 'get the list of posts' do
        get '/v1/examples/all'
        last_response.status.should == 200
      end
      
      it 'create a post' do
        post '/v1/examples/create', {
          name: 'Name',
          description: 'Desc.'
        }
        last_response.status.should == 200
      end
      
      it 'get a specific post' do
        #pending 'Need to find a way to reset the auto_increment on Sqlite3'
        
        get '/v1/examples/show/1'
        last_response.status.should == 200
        post = JSON.parse(last_response.body)
        post['name'].should == 'Name'
        post['description'].should == 'Desc.'
      end
      
    end
    ##################
    # END - Examples #
    ##################
    
  end
  
end