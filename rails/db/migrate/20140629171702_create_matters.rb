class CreateMatters < ActiveRecord::Migration
  def change
    create_table :matters do |t|
      t.string :court_code
      t.string :case_type
      t.string :case_number

      t.timestamps
    end
    add_index :matters, :court_code
    add_index :matters, :case_type
    add_index :matters, :case_number
    add_index :matters, [:case_number, :case_type]
  end
end
