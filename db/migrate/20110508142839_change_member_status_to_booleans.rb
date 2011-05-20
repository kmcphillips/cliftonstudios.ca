class ChangeMemberStatusToBooleans < ActiveRecord::Migration
  def self.up
    remove_column :members, :status
    add_column :members, :admin, :boolean, :default => false
    add_column :members, :active, :boolean, :default => true
    add_column :members, :password_configured, :boolean, :default => false
    add_column :members, :profile_configured, :boolean, :default => false

    add_index :members, :admin
    add_index :members, :active
    add_index :members, :password_configured
    add_index :members, :profile_configured

    remove_column :members, :fingerprint
    remove_column :posts, :status
    remove_column :events, :status
  end

  def self.down
    add_column :members, :status, :string, :default => "active"
    add_index :members, :status

    remove_column :members, :admin
    remove_column :members, :active
    remove_column :members, :password_configured
    remove_column :members, :profile_configured

    add_column :members, :fingerprint, :string
    add_column :posts, :status, :string, :default => "unsent"
    add_column :events, :status, :string, :default => "unsent"
  end
end
