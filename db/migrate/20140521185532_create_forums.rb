class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :name, null: false
      t.integer :rank, null: false
      t.references :section, index: true, null: false

      t.timestamps
    end
  end
end
