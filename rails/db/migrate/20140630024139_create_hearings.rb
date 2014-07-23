class CreateHearings < ActiveRecord::Migration
  def change
    create_table :hearings do |t|
      t.references :department, index: true
      t.references :proceeding, index: true
      t.datetime   :date_time
      t.string     :interpreter

      t.timestamps
    end
    add_index :hearings, :date_time
  end
end
