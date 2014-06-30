class CreateMatters < ActiveRecord::Migration
  def change
    create_table :matters do |t|
      t.references :calendar, index: true
      t.references :case_number, index: true
      t.string     :department

      t.timestamps
    end
    add_index :matters, :department
  end
end

