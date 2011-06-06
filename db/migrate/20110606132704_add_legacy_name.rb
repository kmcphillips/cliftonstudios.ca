class AddLegacyName < ActiveRecord::Migration
  def self.up
    add_column :members, :legacy_name, :string
    add_index :members, :legacy_name
  end

  def self.down
    remove_column :members, :legacy_name
  end
end
