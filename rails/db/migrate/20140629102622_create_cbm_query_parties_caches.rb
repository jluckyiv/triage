class CreateCbmQueryPartiesCaches < ActiveRecord::Migration
  def change
    create_table :cbm_query_parties_caches do |t|
      t.string :court_code
      t.string :case_type
      t.string :case_number
      t.string :md5
      t.integer :content_length

      t.timestamps
    end
    add_index :cbm_query_parties_caches, :court_code
    add_index :cbm_query_parties_caches, :case_type
    add_index :cbm_query_parties_caches, :case_number
    add_index :cbm_query_parties_caches, [:case_number, :case_type]
    add_index :cbm_query_parties_caches, :md5
  end
end
