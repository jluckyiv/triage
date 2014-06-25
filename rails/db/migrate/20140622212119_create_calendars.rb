class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :date

      t.timestamps
    end
  end
end
