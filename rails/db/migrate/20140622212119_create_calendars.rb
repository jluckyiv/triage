class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :date

      t.timestamps
    end

    add_index :calendars, :date
  end
end
