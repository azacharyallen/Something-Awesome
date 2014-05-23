class UniqueBookmarks < ActiveRecord::Migration
  def change
    add_index :bookmarks, [:user_id, :post_thread_id], unique: true
  end
end
