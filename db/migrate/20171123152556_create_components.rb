class CreateComponents < ActiveRecord::Migration[5.1]
  def change
    create_table :components do |t|
      t.belongs_to :website, index: true
      t.string :name
      t.boolean :show
      t.integer :pos 
      t.string :icon
      t.string :icon_color
      t.string :theme
      t.string :title
      t.string :intro
      t.boolean :show_markdown
      t.text :markdown
      t.timestamps
    end
  end
end
