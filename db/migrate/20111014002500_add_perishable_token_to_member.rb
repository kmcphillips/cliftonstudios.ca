class AddPerishableTokenToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :perishable_token, :string

    add_index :members, :perishable_token
  end

  def self.down
    remove_column :members, :perishable_token
  end
end
