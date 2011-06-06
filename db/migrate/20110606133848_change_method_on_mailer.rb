class ChangeMethodOnMailer < ActiveRecord::Migration
  def self.up
    rename_column :pending_emails, :method, :action
  end

  def self.down
    rename_column :pending_emails, :action, :method
  end
end
