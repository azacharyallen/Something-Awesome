class BannedAttribute < ActiveRecord::Migration
  def change
    add_column :users, :banned, :boolean, default: FALSE
  end
end
