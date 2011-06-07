class AddSecretHashToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :secret_hash, :string
    add_column :members, :legacy_username, :string
  end

  def self.down
    remove_column :members, :secret_hash
    remove_column :members, :legacy_username
  end
end
