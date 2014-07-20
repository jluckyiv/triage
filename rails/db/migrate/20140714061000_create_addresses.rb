class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.string :zip
      t.references :addressable, polymorphic: true, index: true

      t.timestamps
    end

    add_index :addresses, :street1
    add_index :addresses, :city
    add_index :addresses, :state
    add_index :addresses, :zip
    add_index :addresses, [:street1, :zip, :street2], unique: true
  end
end
