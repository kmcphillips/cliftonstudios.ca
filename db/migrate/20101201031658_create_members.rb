class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.string :status, :default => "active"
      t.boolean :visible, :default => false
      t.string :name
      t.string :phone
      t.text :address
      t.string :permalink
      t.text :bio
      t.boolean :receive_emails, :default => true
      
      ## paperclip
      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.string :image_updated_at

      ## authlogic
      t.string :email, :null => false
      t.string :crypted_password, :null => false
      t.string :password_salt, :null => false
      t.string :persistence_token, :null => false
      t.integer :login_count, :null => false, :default => 0
      t.datetime :current_login_at
      t.datetime :last_login_at  
      
      t.timestamps
    end
    
    add_index :members, :status
    add_index :members, :visible
    add_index :members, :receive_emails
    add_index :members, :email, :unique => true
    add_index :members, :persistence_token, :unique => true
  end

  def self.down
    drop_table :members
  end
end
