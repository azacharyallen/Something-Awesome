class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body, null: false
      t.references :user, index: true
      t.references :post_thread, index: true

      t.timestamps
    end
  end
end
