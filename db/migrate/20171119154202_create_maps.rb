class CreateMaps < ActiveRecord::Migration[5.1]
  def change
    create_table :maps do |t|
      t.belongs_to :website, index: true
      t.integer :helper
      t.integer :pos
      t.string :title
      t.string :intro
      t.text :geo
      t.text :markdown
      t.timestamps
    end
  end
end
