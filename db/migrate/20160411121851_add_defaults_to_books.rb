class AddDefaultsToBooks < ActiveRecord::Migration[5.0]
  def change
    change_column :books, :in_library, :boolean, default: false
    change_column_null :books, :in_library, false, true
  end
end
