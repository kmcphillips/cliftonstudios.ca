class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :member_id
      t.string :title
      t.string :permalink
      t.text :body
      t.boolean :members_only, :default => false
      t.string :status, :default => "unsent"

      ## paperclip
      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.string :image_updated_at

      t.timestamps
    end

    add_index :posts, :member_id
    add_index :posts, :permalink
    add_index :posts, :status
    add_index :posts, :created_at
  end

  def self.down
    drop_table :posts
  end
end
