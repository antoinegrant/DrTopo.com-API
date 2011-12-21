require 'active_record'
module API
  module V1
    
    class Example < ActiveRecord::Base
      validates :name, :presence => true
      validates :description, :presence => true
    end
    
  end
end