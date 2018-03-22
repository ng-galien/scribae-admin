class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.belongs_to :website, index: true
      t.integer :index
      t.string :title
      t.string :intro
      t.boolean :extern
      t.string :link
      t.timestamps
    end
  end
end
