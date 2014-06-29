class CreateCbmPartiesQueryCaches < ActiveRecord::Migration
  def change
    create_table :cbm_parties_query_caches do |t|
      t.string :court_code
      t.string :case_type
      t.string :case_number
      t.text :body
      t.string :md5
      t.integer :content_length

      t.timestamps
    end
    add_index :cbm_parties_query_caches, :court_code
    add_index :cbm_parties_query_caches, :case_type
    add_index :cbm_parties_query_caches, :case_number
  end
end
