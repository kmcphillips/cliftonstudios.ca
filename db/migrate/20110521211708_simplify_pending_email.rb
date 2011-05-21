class SimplifyPendingEmail < ActiveRecord::Migration
  def self.up
    remove_column :pending_emails, :member_id
    remove_column :pending_emails, :everyone
  end

  def self.down
    add_column :pending_emails, :member_id, :integer
    add_column :pending_emails, :everyone, :boolean, :default => false
  end
end
