class AddContactMethodToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :contact_method, :string
  end

  def self.down
    remove_column :members, :contact_method
  end
end
