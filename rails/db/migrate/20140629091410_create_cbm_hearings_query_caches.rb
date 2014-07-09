class CreateCbmHearingsQueryCaches < ActiveRecord::Migration
  def change
    create_table :cbm_hearings_query_caches do |t|
      t.string  :court_code
      t.string  :department
      t.string  :date
      t.string  :md5
      t.integer :content_length

      t.timestamps
    end
    add_index :cbm_hearings_query_caches, :court_code
    add_index :cbm_hearings_query_caches, :department
    add_index :cbm_hearings_query_caches, :date
    add_index :cbm_hearings_query_caches, [:date, :department, :court_code], unique: true, name: 'index_cbm_hearings_query_caches_on_date_dept_cc'
    add_index :cbm_hearings_query_caches, :md5
  end
end
