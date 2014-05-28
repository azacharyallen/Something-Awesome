class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :post_thread, index: true
      t.references :user, index: true
      t.references :post, index: true, null: false

      t.timestamps
    end
    add_index :visits, [:post_thread_id, :user_id], unique: true
  end
end
