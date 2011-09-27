class AddTypeAndSpaceNumberToMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :renting, :boolean, :default => true
    add_column :members, :subletting_member_id, :integer
    add_column :members, :space_number, :string

    add_index :members, :renting
    add_index :members, :subletting_member_id
  end

  def self.down
    remove_column :members, :renting
    remove_column :members, :subletting_member_id
    remove_column :members, :space_number
  end
end
