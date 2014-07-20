class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.string :first
      t.string :middle
      t.string :last
      t.string :suffix
      t.references :nameable, polymorphic: true, index: true

      t.timestamps
    end
    add_index :names, :first
    add_index :names, :middle
    add_index :names, :last
    add_index :names, :suffix
    add_index :names, [:first, :last]
    add_index :names, [:first, :middle, :last, :suffix]
  end
end
