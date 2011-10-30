class AddMemberSince < ActiveRecord::Migration
  def self.up
    add_column :members, :member_since_year, :integer
    add_column :members, :member_since_month, :string
  end

  def self.down
    remove_column :members, :member_since_year
    remove_column :members, :member_since_month
  end
end
