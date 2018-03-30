class CreateInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :infos do |t|
      t.belongs_to :website, index: true
      t.integer :helper 
      t.integer :pos
      t.string :title
      t.text :markdown
      t.timestamps
    end
  end
end
