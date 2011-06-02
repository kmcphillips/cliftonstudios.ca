class AddAltPhone < ActiveRecord::Migration
  def self.up
    add_column :members, :alternate_phone, :string
  end

  def self.down
    remove_column :members, :alternate_phone
  end
end
