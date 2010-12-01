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

ActiveRecord::Schema.define(:version => 20101201145429) do

  create_table "members", :force => true do |t|
    t.string   "status",             :default => "active"
    t.boolean  "visible",            :default => false
    t.string   "name"
    t.string   "phone"
    t.text     "address"
    t.string   "permalink"
    t.text     "bio"
    t.boolean  "receive_emails",     :default => true
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.string   "image_updated_at"
    t.string   "email",                                    :null => false
    t.string   "crypted_password",                         :null => false
    t.string   "password_salt",                            :null => false
    t.string   "persistence_token",                        :null => false
    t.integer  "login_count",        :default => 0,        :null => false
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["email"], :name => "index_members_on_email", :unique => true
  add_index "members", ["permalink"], :name => "index_members_on_permalink"
  add_index "members", ["persistence_token"], :name => "index_members_on_persistence_token", :unique => true
  add_index "members", ["receive_emails"], :name => "index_members_on_receive_emails"
  add_index "members", ["status"], :name => "index_members_on_status"
  add_index "members", ["visible"], :name => "index_members_on_visible"

  create_table "posts", :force => true do |t|
    t.integer  "member_id"
    t.string   "title"
    t.string   "permalink"
    t.text     "body"
    t.boolean  "members_only",       :default => false
    t.string   "status",             :default => "unsent"
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
  add_index "posts", ["status"], :name => "index_posts_on_status"

end
