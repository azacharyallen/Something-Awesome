class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name, null: false
      t.integer :rank, null: false

      t.timestamps
    end
    add_index :sections, :name, unique: true
    add_index :sections, :rank, unique: true
  end
end
