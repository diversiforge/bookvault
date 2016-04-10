class FunWithSchemaChanges < ActiveRecord::Migration[5.0]
  def change
    create_table :media_types do |t|
      t.string :name, null: false
    end

    create_table :acquisition_types do |t|
      t.string :name, null: false
    end

    create_table :transacting_entities do |t|
      t.string :name, null: false
      t.timestamps
      t.index :name
    end

    change_table :books do |t|
      t.boolean :in_library
      t.integer :media_type_id
      t.integer :source_id
      t.integer :recipient_id
      t.integer :acquisition_type_id
      t.index :media_type_id
      t.index :source_id
      t.index :recipient_id
      t.index :acquisition_type_id
    end
  end
end
