class CreateTerminalLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :terminal_logs do |t|
      t.integer :helper
      t.string :info
      t.string :level
      t.text :message
      t.references :loggable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
