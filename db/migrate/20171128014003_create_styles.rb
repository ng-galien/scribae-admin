class CreateStyles < ActiveRecord::Migration[5.1]
  def change
    create_table :styles do |t|
      t.string :primary
      t.string :secondary
      t.string :background
      t.string :icon
      t.string :text
      t.string :decoration
      t.references :stylable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
