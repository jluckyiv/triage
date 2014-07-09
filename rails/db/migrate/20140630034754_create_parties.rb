class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.references :case_number, index: true
      t.integer :number
      t.string :category
      t.string :first
      t.string :middle
      t.string :last
      t.string :suffix

      t.timestamps
    end
    add_index :parties, :number
    add_index :parties, :category
    add_index :parties, :first
    add_index :parties, :middle
    add_index :parties, :last
    add_index :parties, :suffix
    add_index :parties, [:last, :first]
  end
end
