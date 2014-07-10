class CreateHearings < ActiveRecord::Migration
  def change
    create_table :hearings do |t|
      t.references :matter, index: true
      t.string :time
      t.text :description
      t.string :interpreter
      t.string :md5

      t.timestamps
    end
    add_index :hearings, :time
    add_index :hearings, :md5
    add_index :hearings, [:md5, :matter_id, :time], unique: true
  end
end
