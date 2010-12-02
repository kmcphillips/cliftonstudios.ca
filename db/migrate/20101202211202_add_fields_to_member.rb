class AddFieldsToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :fingerprint, :string
    add_column :members, :website, :string
  end

  def self.down
    remove_column :members, :fingerprint
    remove_column :members, :website
  end
end
