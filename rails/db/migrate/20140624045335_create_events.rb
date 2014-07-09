class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :matter, index: true
      t.string :category
      t.string :subject
      t.string :action
      t.integer :timestamp, :limit => 8

      t.timestamps
    end
    add_index :events, :category
    add_index :events, :subject
    add_index :events, :action
    add_index :events, [:action, :subject, :category]
    add_index :events, :timestamp
  end
end
