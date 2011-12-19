require File.join(File.dirname(__FILE__), '..', 'config/application.rb')
require 'spec_helper'

describe 'The API should, ' do
  it 'get the home page' do
    get '/'
    last_response.status.should == 200
  end
end