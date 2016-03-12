class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.integer :publisher_id
      t.string :isbn10
      t.string :isbn13
      t.datetime :date_added
      t.text :raw_barcode
      t.string :google_volume_id
      t.text :google_volume_raw_data
      t.string :title
      t.string :subtitle
      t.date :published_date
      t.text :description
      t.integer :page_count
      t.index :publisher_id
      t.index :isbn10
      t.index :isbn13
      t.index :date_added
      t.index :title
      t.timestamps
    end
  end
end
