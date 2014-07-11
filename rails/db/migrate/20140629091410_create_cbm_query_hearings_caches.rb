class CreateCbmQueryHearingsCaches < ActiveRecord::Migration
  def change
    create_table :cbm_query_hearings_caches do |t|
      t.string  :court_code
      t.string  :department
      t.string  :date
      t.string  :md5
      t.integer :content_length

      t.timestamps
    end
    add_index :cbm_query_hearings_caches, :court_code
    add_index :cbm_query_hearings_caches, :department
    add_index :cbm_query_hearings_caches, :date
    add_index :cbm_query_hearings_caches, [:date, :department, :court_code], unique: true, name: 'index_cbm_hearings_query_caches_on_date_dept_cc'
    add_index :cbm_query_hearings_caches, :md5
  end
end
