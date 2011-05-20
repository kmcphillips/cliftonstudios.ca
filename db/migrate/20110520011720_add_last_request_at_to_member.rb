class AddLastRequestAtToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :last_request_at, :datetime
  end

  def self.down
    remove_column :members, :last_request_at
  end
end
