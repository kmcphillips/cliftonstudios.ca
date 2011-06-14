class RemoveRedundantTitleOnPicture < ActiveRecord::Migration
  def self.up
    remove_column :pictures, :title
  end

  def self.down
    add_column :pictures, :title, :string
  end
end
