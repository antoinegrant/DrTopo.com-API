class Example01 < ActiveRecord::Migration
  def self.up
    create_table :examples do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :examples
  end
end
