class CreateCbmHearingsQueries < ActiveRecord::Migration
  def change
    create_table :cbm_hearings_queries do |t|
      t.string :court_code
      t.string :department
      t.string :date
      t.string :md5

      t.timestamps
    end
    add_index :cbm_hearings_queries, :court_code
    add_index :cbm_hearings_queries, :department
    add_index :cbm_hearings_queries, :date
    add_index :cbm_hearings_queries, :md5
  end
end
