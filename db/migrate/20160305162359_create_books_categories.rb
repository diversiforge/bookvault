class CreateBooksCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :books_categories do |t|
      t.integer :book_id
      t.integer :category_id
      t.index :book_id
      t.index :category_id
      t.timestamps
    end
  end
end
