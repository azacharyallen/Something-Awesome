class ReworkAvatars < ActiveRecord::Migration
  def change
    remove_attachment :users, :s3avatar
    remove_column :users, :avatar
    add_attachment :users, :avatar
  end
end
