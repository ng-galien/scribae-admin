class CreatePreviews < ActiveRecord::Migration[5.1]
  def change
    create_table :previews do |t|
      t.integer :website_id
      t.integer :pid
      t.float :updated
      t.boolean :running
      t.boolean :created
      t.string :root_path
      t.string :url 
      t.integer :port
      t.text :log  
      t.timestamps
    end
    add_index :previews, :website_id
  end
end
