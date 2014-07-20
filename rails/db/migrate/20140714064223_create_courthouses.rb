class CreateCourthouses < ActiveRecord::Migration
  def change
    create_table :courthouses do |t|
      t.string :branch_name
      t.string :county

      t.timestamps
    end
    add_index :courthouses, :branch_name, unique: true
    add_index :courthouses, :county
  end
end
