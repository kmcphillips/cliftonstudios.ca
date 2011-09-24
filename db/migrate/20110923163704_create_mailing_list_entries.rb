class CreateMailingListEntries < ActiveRecord::Migration
  def self.up
    create_table :mailing_list_entries do |t|
      t.string :email
      t.string :ip_address
      t.boolean :active, :default => true

      t.timestamps
    end
    
    add_index :mailing_list_entries, :ip_address
    add_index :mailing_list_entries, :active
  end

  def self.down
    drop_table :mailing_list_entries
  end
end
