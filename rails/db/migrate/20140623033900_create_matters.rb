class CreateMatters < ActiveRecord::Migration
  def change
    create_table :matters do |t|
      t.references :calendar, index: true
      t.string :case_number
      t.string :department
      t.string :petitioner
      t.string :respondent

      t.timestamps
    end
    add_index :matters, :case_number
    add_index :matters, :department
    add_index :matters, :petitioner
    add_index :matters, :respondent
  end
end

