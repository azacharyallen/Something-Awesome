class AddClosedAttributeToPostThreads < ActiveRecord::Migration
  def change
    add_column :post_threads, :closed, :boolean, default: false
  end
end
