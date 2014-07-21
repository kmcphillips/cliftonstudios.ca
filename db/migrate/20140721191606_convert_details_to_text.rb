class ConvertDetailsToText < ActiveRecord::Migration
  def change
    change_column :audits, :details, :text
  end
end
