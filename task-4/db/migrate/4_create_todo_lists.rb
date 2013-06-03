class CreateTodolists < ActiveRecord::Migration
  def self.up
    create_table :todo_lists do |t|
      t.string :title
      t.references :user
      
      t.timestamps
    end
  end
  
  def self.down
     drop_table :todo_lists
  end
end
