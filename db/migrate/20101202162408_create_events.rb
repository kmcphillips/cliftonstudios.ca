class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :member_id
      t.string :title
      t.string :permalink
      t.text :body
      t.boolean :members_only, :default => false
      t.string :status, :default => "unsent"
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer :duration, :default => 1
      
      # paperclip
      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.string :image_updated_at

      t.timestamps
    end
    
    add_index :events, :member_id
    add_index :events, :permalink
    add_index :events, :status
    add_index :events, :created_at
    add_index :events, :starts_at
  end

  def self.down
    drop_table :events
  end
end
