class Areas < ActiveRecord::Migration
  def self.up
    
    create_table :areas do |t|
      t.timestamps
      t.integer :guid
      t.boolean :state, :null => false
      t.string  :name_en_index
      t.string  :name_en
      t.string  :name_fr
      t.text    :description_en
      t.text    :description_fr
      t.string  :nickname_en
      t.string  :nickname_fr
      t.string  :seasons
      t.string  :type_of_climbing
      t.integer :continent
      t.integer :country
      t.integer :state
      t.integer :nearest_city
      t.integer :file_pdf
      t.decimal :longitude, :precision => 15, :scale => 10
      t.decimal :latitude , :precision => 15, :scale => 10
    end
    
  end
  
  def self.down
    drp_table :areas
  end
end
