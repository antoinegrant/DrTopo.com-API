require File.dirname(__FILE__) + '/spec_helper'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

describe 'Test the app, ' do
  
  def app
    Sinatra::Application
  end
  
  before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  
  before(:each) do
    DatabaseCleaner.start
    Product.create(
      :name => "test",
      :description => "desc"
    )
  end
  
  after(:each) do
    DatabaseCleaner.clean
  end
  
  ###############
  # Begin tests #
  ###############
  it 'get the first post' do
    get '/hello'
    last_response.status.should == 200
    JSON.parse(last_response.body)['product']['description'].should == "desc"
  end
  
  it 'get the environment' do
    get '/env'
    last_response.status.should == 200
    last_response.body.should == '{"env":"test"}'
  end
end