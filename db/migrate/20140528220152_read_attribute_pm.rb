class ReadAttributePm < ActiveRecord::Migration
  def change
    add_column :private_messages, :read, :boolean, default: FALSE
  end
end
