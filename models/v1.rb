require 'active_record'
module API
  module V1
    
    ActiveRecord::Base.include_root_in_json = false
    
    class Example < ActiveRecord::Base
      validates :name, :presence => true
      validates :description, :presence => true
    end
    
  end
end