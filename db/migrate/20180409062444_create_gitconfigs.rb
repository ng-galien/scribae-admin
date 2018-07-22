class CreateGitconfigs < ActiveRecord::Migration[5.1]
  def change
    create_table :gitconfigs do |t|
      t.integer :website_id
      t.string :base_url
      t.string :user
      t.string :email
      t.boolean :initialized
      t.string :repo_link 
      t.string :website_link
      t.datetime :last_commit
      t.timestamps
    end
    add_index :gitconfigs, :website_id
  end
end
