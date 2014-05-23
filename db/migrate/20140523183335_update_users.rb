class UpdateUsers < ActiveRecord::Migration
  def change
    remove_column :users, :email
    add_column :users, :profile, :text, default: "I haven't written anything here yet."
  end
end
