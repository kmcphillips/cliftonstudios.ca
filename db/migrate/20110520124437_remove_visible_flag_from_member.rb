class RemoveVisibleFlagFromMember < ActiveRecord::Migration
  def self.up
    remove_column :members, :visible
  end

  def self.down
    add_column :members, :visible, :boolean, :default => true
    add_index :members, :visible
  end
end
