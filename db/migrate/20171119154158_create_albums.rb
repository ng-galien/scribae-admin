class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.belongs_to :website, index: true
      t.integer :helper
      t.integer :pos
      t.string :title
      t.string :intro
      t.boolean :extern
      t.string :link
      t.text :markdown
      t.timestamps
    end
  end
end
