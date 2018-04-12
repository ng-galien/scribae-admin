class CreateGitconfigs < ActiveRecord::Migration[5.1]
  def change
    create_table :gitconfigs do |t|
      t.integer :website_id
      t.string :repo
      t.string :user
      t.string :email
      t.boolean :initialized
      t.string :link 
      t.datetime :last_commit
      t.timestamps
    end
    add_index :gitconfigs, :website_id
  end
end
