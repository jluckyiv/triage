class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :date
      t.string :slug

      t.timestamps
    end
    add_index :calendars, :slug, unique: true
  end
end
