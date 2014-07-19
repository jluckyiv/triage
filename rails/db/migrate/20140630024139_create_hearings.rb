class CreateHearings < ActiveRecord::Migration
  def change
    create_table :hearings do |t|
      t.references :matter, index: true
      t.references :department, index: true
      t.datetime   :date_time
      t.string     :interpreter
      t.text       :description
      t.string     :description_digest

      t.timestamps
    end
    add_index :hearings, :date_time
    add_index :hearings, :description_digest
  end
end
