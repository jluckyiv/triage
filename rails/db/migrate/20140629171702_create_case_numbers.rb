class CreateCaseNumbers < ActiveRecord::Migration
  def change
    create_table :case_numbers do |t|
      t.string :court_code
      t.string :case_type
      t.string :case_number

      t.timestamps
    end
    add_index :case_numbers, :court_code
    add_index :case_numbers, :case_type
    add_index :case_numbers, :case_number
  end
end
