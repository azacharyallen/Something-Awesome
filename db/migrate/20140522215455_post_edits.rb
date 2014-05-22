class PostEdits < ActiveRecord::Migration
  def change
    add_column :posts, :edited, :string, default: ""
  end
end
