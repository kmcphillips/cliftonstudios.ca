class CreatePendingEmails < ActiveRecord::Migration
  def self.up
    create_table :pending_emails do |t|
      t.string :method
      t.text :locals
      t.integer :member_id
      t.boolean :everyone, :default => false
      t.boolean :processing, :default => false
      
      t.timestamps
    end

    add_index :pending_emails, :created_at
  end

  def self.down
    drop_table :pending_emails
  end
end

