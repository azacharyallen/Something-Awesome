class S3avatars < ActiveRecord::Migration
  def self.up
    add_attachment :users, :s3avatar
  end

  def self.down
    remove_attachment :users, :s3avatar
  end
end
