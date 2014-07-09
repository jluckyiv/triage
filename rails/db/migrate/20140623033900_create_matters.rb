class CreateMatters < ActiveRecord::Migration
  def change
    create_table :matters do |t|
      t.references :case_number, index: true
      t.string     :date
      t.string     :department

      t.timestamps
    end
    add_index :matters, :date
    add_index :matters, :department
    add_index :matters, [:date, :department]
  end
end

