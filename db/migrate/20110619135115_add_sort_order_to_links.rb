class AddSortOrderToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :sort_order, :integer
  end

  def self.down
    remove_column :links, :sort_order
  end
end
