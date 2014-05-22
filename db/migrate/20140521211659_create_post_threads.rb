class CreatePostThreads < ActiveRecord::Migration
  def change
    create_table :post_threads do |t|
      t.string :title, null: false
      t.references :user, index: true, null: false
      t.references :forum, index: true, null: false

      t.timestamps
    end
  end
end
