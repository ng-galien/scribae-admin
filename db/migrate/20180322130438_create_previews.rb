class CreatePreviews < ActiveRecord::Migration[5.1]
  def change
    create_table :previews do |t|
      t.integer :website_id
      t.string :prototype
      t.string :name
      t.integer :status
      t.integer :process
      t.string :url  
      t.datetime :last_commit
      t.timestamps
    end
    add_index :previews, :website_id
  end
end
