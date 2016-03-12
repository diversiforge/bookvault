class AddSplitDateFieldsToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :published_year, :integer
    add_column :books, :published_month, :integer
    add_column :books, :published_day, :integer
    add_index :books, :published_year
    add_index :books, :published_month
    add_index :books, :published_day
  end
end
