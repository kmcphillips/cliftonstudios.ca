class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.integer :member_id
      t.string :title
      t.text :description
            
      # paperclip
      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.string :image_updated_at
      
      t.timestamps
    end
    
    add_index :pictures, :member_id
  end

  def self.down
    drop_table :pictures
  end
end
