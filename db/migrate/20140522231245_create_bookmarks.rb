class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, index: true
      t.references :post_thread, null: false, index: true

      t.timestamps
    end
  end
end
