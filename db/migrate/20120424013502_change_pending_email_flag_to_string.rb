class ChangePendingEmailFlagToString < ActiveRecord::Migration
  def self.up
  	remove_column :pending_emails, :processing
  	add_column :pending_emails, :status, :string, :default => "pending"
  	add_index :pending_emails, :status

    PendingEmail.update_all "`status` = 'complete'"
  end

  def self.down
  	add_column :pending_emails, :processing, :boolean, :default => false
  	remove_column :pending_emails, :status
  end
end
