class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.references :matter, index: true
      t.references :attorney, index: true
      t.integer    :number
      t.string     :role
      t.datetime   :dob
      t.string     :phone
      t.string     :email

      t.timestamps
    end
    add_index :parties, :number
    add_index :parties, :role
  end
end
