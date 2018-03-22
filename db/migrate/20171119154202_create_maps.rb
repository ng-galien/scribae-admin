class CreateMaps < ActiveRecord::Migration[5.1]
  def change
    create_table :maps do |t|
      t.belongs_to :website, index: true
      t.timestamps
    end
  end
end
