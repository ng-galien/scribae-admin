class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.integer :index
      t.string :category
      t.string :name
      t.string :intro
      t.references :imageable, polymorphic: true, index: true
      t.string :upload
      t.timestamps
    end
  end
end
