class CreateMinutes < ActiveRecord::Migration
  def self.up
    create_table :minutes do |t|
      t.string :description
      t.datetime :recorded_at
      t.integer :member_id

      t.string  :file_file_name
      t.integer  :file_file_size
      t.string  :file_content_type
      t.string  :file_updated_at

      t.timestamps
    end

    add_index :minutes, :recorded_at
    add_index :minutes, :member_id
  end

  def self.down
    drop_table :minutes
  end
end
