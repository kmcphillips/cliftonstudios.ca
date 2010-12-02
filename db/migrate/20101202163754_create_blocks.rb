class CreateBlocks < ActiveRecord::Migration
  def self.up
    create_table :blocks do |t|
      t.text :body
      t.string :label
      t.string :path
      t.string :description
      t.boolean :accepts_image, :default => false

      # paperclip
      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.string :image_updated_at

      t.timestamps
    end

    add_index :blocks, :label
  end

  def self.down
    drop_table :blocks
  end
end
