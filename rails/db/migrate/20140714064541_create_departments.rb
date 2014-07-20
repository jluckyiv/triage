class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.references :courthouse, index: true
      t.string :judicial_officer

      t.timestamps
    end
    add_index :departments, :name, unique: true
  end
end
