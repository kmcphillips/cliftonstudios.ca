class RemoveProfileFlagFromMember < ActiveRecord::Migration
  def self.up
    remove_column :members, :profile_configured
  end

  def self.down
    add_column :members, :profile_configured, :default => false
    add_index :members, :profile_configured
  end
end
