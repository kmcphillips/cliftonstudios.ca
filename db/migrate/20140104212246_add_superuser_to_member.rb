class AddSuperuserToMember < ActiveRecord::Migration
  def change
    add_column :members, :superuser, :boolean, default: false
  end
end
