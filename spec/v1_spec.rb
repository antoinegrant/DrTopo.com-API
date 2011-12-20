require File.join(File.dirname(__FILE__), '..', 'config/application.rb')
require 'spec_helper'

describe 'The API should, ' do
  it 'get the home page' do
    get '/'
    last_response.status.should == 200
  end
  it 'be in test mode' do
    get '/env'
    JSON.parse(last_response.body)['env'].should == 'test'
  end
end