class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.belongs_to :website, index: true
      t.boolean :fake
      t.datetime :date
      t.boolean :featured
      t.string :title
      t.string :intro
      t.text :markdown
      t.timestamps
    end
  end
end
