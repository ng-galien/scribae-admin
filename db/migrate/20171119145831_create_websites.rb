class CreateWebsites < ActiveRecord::Migration[5.1]
  def change
    create_table :websites do |t|
      # General
      t.integer :helper
      t.string :name
      t.string :description
      t.text :readme
      # Site content
      t.string :site_title
      t.string :home_title
      t.string :home_icon
      t.string :top_title
      t.string :top_intro
      t.string :bottom_title
      t.string :bottom_intro
      t.string :featured_title
      t.boolean :show_featured
      t.boolean :show_markdown
      t.text :markdown
      
      t.timestamps
    end
  end
end
