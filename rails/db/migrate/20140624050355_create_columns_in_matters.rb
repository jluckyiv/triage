class CreateColumnsInMatters < ActiveRecord::Migration
  def change
    create_table :columns_in_matters do |t|
      add_column :matters, :petitioner,        :string
      add_column :matters, :respondent,        :string
      add_column :matters, :petitioner_present, :boolean
      add_column :matters, :respondent_present, :boolean
    end
    add_index :matters, :petitioner
    add_index :matters, :respondent
  end
end
