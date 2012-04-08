class AddAgreementFlag < ActiveRecord::Migration
  def self.up
    add_column :members, :agreement_signed, :boolean, :default => false
    add_index :members, :agreement_signed
  end

  def self.down
    remove_column :members, :agreement_signed
  end
end
