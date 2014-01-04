class RemoveSuperuser < ActiveRecord::Migration
  def up
    remove_column :members, :superuser
  end

  def down
    add_column :members, :superuser, :boolean, default: false
  end
end
