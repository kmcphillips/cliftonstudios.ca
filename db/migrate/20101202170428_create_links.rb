class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links, :force => true do |t|
      t.string   "title"
      t.string   "url"
      t.text     "description"
      
      t.timestamps
    end

    add_index :links, :created_at
  end

  def self.down
    drop_table :links
  end
end
