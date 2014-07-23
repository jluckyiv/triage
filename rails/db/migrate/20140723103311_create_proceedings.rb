class CreateProceedings < ActiveRecord::Migration
  def change
    create_table :proceedings do |t|
      t.references :matter, index: true
      t.string :description_digest
      t.text :description

      t.timestamps
    end
    add_index :proceedings, :description_digest
  end
end
