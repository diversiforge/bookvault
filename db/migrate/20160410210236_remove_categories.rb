class RemoveCategories < ActiveRecord::Migration[5.0]
  def change
    drop_table :categories
    drop_table :books_categories
  end
end
