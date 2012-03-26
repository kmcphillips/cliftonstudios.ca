class CreateSystemVariables < ActiveRecord::Migration
  def self.up
    create_table :system_variables do |t|
      t.string :key
      t.string :value

      t.timestamps
    end

    SystemVariable.create! :key => "readonly", :value => "false"

    add_column :members, :system, :boolean, :default => false
  end

  def self.down
    drop_table :system_variables

    remove_column :members, :system
  end
end
