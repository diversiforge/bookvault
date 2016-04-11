class CreateSystemConfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :system_configs do |t|
      t.string :library_name
      t.boolean :public_book_display
      t.timestamps
    end
  end
end
