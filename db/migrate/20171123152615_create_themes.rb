class CreateThemes < ActiveRecord::Migration[5.1]
  def change
    create_table :themes do |t|
      t.belongs_to :website, index: true
      t.integer :helper 
      t.integer :pos
      t.string :title
      t.string :intro
      t.text :markdown
      t.timestamps
    end
  end
end
