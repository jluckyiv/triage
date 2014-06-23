class CreateMatters < ActiveRecord::Migration
  def change
    create_table :matters do |t|
      t.references :calendar, index: true
      t.string :case_number
      t.string :department

      t.timestamps
    end
    add_index :matters, :case_number
    add_index :matters, :department
  end
end
