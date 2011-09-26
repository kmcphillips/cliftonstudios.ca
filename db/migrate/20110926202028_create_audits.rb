class CreateAudits < ActiveRecord::Migration
  def self.up
    create_table :audits do |t|
      t.integer :auditable_id
      t.string :auditable_type
      t.integer :member_id
      t.string :action, :default => "update"
      t.string :details

      t.timestamps
    end

    add_index :audits, :auditable_id
    add_index :audits, :auditable_type
    add_index :audits, [:auditable_type, :auditable_id]
    add_index :audits, :member_id
  end

  def self.down
    drop_table :audits
  end
end
