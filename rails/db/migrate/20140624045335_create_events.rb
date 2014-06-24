class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :matter, index: true
      t.string :type
      t.string :subject
      t.string :action
      t.integer :timestamp

      t.timestamps
    end
    add_index :events, :type
    add_index :events, :subject
    add_index :events, :action
    add_index :events, :timestamp
  end
end
