class AddIndexToPictures < ActiveRecord::Migration
  def change
    add_index :pictures, :created_at
  end
end
