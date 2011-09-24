# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110923163704) do

  create_table "blocks", :force => true do |t|
    t.text     "body"
    t.string   "label"
    t.string   "path"
    t.string   "description"
    t.boolean  "accepts_image",      :default => false
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.string   "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blocks", ["label"], :name => "index_blocks_on_label"

  create_table "events", :force => true do |t|
    t.integer  "member_id"
    t.string   "title"
    t.string   "permalink"
    t.text     "body"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "duration",           :default => 1
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.string   "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["created_at"], :name => "index_events_on_created_at"
  add_index "events", ["member_id"], :name => "index_events_on_member_id"
  add_index "events", ["permalink"], :name => "index_events_on_permalink"
  add_index "events", ["starts_at"], :name => "index_events_on_starts_at"

  create_table "executives", :force => true do |t|
    t.integer  "member_id"
    t.string   "title"
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "executives", ["member_id"], :name => "index_executives_on_member_id"
  add_index "executives", ["sort_order"], :name => "index_executives_on_sort_order"

  create_table "links", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort_order"
  end

  add_index "links", ["created_at"], :name => "index_links_on_created_at"

  create_table "mailing_list_entries", :force => true do |t|
    t.string   "email"
    t.string   "ip_address"
    t.boolean  "active",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mailing_list_entries", ["active"], :name => "index_mailing_list_entries_on_active"
  add_index "mailing_list_entries", ["ip_address"], :name => "index_mailing_list_entries_on_ip_address"

  create_table "members", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.text     "address"
    t.string   "permalink"
    t.text     "bio"
    t.boolean  "receive_emails",      :default => true
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.string   "image_updated_at"
    t.string   "email",                                  :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website"
    t.boolean  "admin",               :default => false
    t.boolean  "active",              :default => true
    t.boolean  "password_configured", :default => false
    t.datetime "last_request_at"
    t.string   "alternate_phone"
    t.string   "legacy_name"
    t.string   "secret_hash"
    t.string   "legacy_username"
  end

  add_index "members", ["active"], :name => "index_members_on_active"
  add_index "members", ["admin"], :name => "index_members_on_admin"
  add_index "members", ["email"], :name => "index_members_on_email", :unique => true
  add_index "members", ["legacy_name"], :name => "index_members_on_legacy_name"
  add_index "members", ["password_configured"], :name => "index_members_on_password_configured"
  add_index "members", ["permalink"], :name => "index_members_on_permalink"
  add_index "members", ["persistence_token"], :name => "index_members_on_persistence_token", :unique => true
  add_index "members", ["receive_emails"], :name => "index_members_on_receive_emails"

  create_table "pending_emails", :force => true do |t|
    t.string   "action"
    t.text     "locals"
    t.boolean  "processing", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pending_emails", ["created_at"], :name => "index_pending_emails_on_created_at"

  create_table "pictures", :force => true do |t|
    t.integer  "member_id"
    t.text     "description"
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.string   "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pictures", ["member_id"], :name => "index_pictures_on_member_id"

  create_table "posts", :force => true do |t|
    t.integer  "member_id"
    t.string   "title"
    t.string   "permalink"
    t.text     "body"
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.string   "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["created_at"], :name => "index_posts_on_created_at"
  add_index "posts", ["member_id"], :name => "index_posts_on_member_id"
  add_index "posts", ["permalink"], :name => "index_posts_on_permalink"

end
