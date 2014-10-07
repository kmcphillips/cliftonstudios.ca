class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string "name"
      t.string "kind", default: 'bylaw'
      t.integer "member_id"
      t.string "file_file_name"
      t.integer "file_file_size"
      t.string "file_content_type"
      t.string "file_updated_at"

      t.timestamps
    end

    add_index :documents, :kind
    add_index :documents, :name
    add_index :documents, :member_id
  end
end
