class CreatePrivateMessages < ActiveRecord::Migration
  def change
    create_table :private_messages do |t|
      t.text :body, null: false
      t.string :title, null: false
      t.integer :author_id, null: false
      t.integer :recipient_id, null: false

      t.timestamps
    end
    add_index :private_messages, :author_id
    add_index :private_messages, :recipient_id
  end
end
