class RemoveMembersOnlyFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :events, :members_only
    remove_column :posts, :members_only
  end

  def self.down
    add_column :events, :members_only, :boolean, :default => false
    add_column :posts, :members_only, :boolean, :default => false
  end
end
