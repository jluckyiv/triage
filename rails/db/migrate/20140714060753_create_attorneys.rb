class CreateAttorneys < ActiveRecord::Migration
  def change
    create_table :attorneys do |t|
      t.string :name
      t.string :name_digest
      t.integer :sbn
      t.string :email
      t.string :phone

      t.timestamps
    end
    add_index :attorneys, :name
    add_index :attorneys, :name_digest, unique: true
    add_index :attorneys, :sbn, unique: true
  end
end
