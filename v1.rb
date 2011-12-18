require './config/application'
require './models/product'

before do
  ActiveRecord::Base.connection.verify!
end

get '/hello' do
  "Hello world! #{@environment}"
  product = Product.find(:all).first
  "#{product.to_json}"
  "Do it! Again!"
end
