class CreateExecutives < ActiveRecord::Migration
  def self.up
    create_table :executives do |t|
      t.integer :member_id
      t.string :title
      t.integer :sort_order

      t.timestamps
    end

    add_index :executives, :member_id
    add_index :executives, :sort_order
  end

  def self.down
    drop_table :executives
  end
end
