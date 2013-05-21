class CreateTodolists < ActiveRecord::Migration
  def change
    create_table :todolists do |t|
      t.string :title
      t.references :user
      
      t.timestamps
    end
  end
end
