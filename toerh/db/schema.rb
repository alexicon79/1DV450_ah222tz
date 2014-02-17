# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20140216205353) do

  create_table "api_keys", :force => true do |t|
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "access_token"
    t.integer  "application_id"
  end

  create_table "applications", :force => true do |t|
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "contact_email"
  end

  create_table "licences", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "licence_type"
  end

  create_table "resource_types", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "type_name"
  end

  create_table "resources", :force => true do |t|
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "resource_type_id"
    t.integer  "licence_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.string   "url"
  end

  add_index "resources", ["licence_id"], :name => "index_resources_on_licence_id"
  add_index "resources", ["resource_type_id"], :name => "index_resources_on_resource_type_id"
  add_index "resources", ["user_id"], :name => "index_resources_on_user_id"

  create_table "resources_tags", :id => false, :force => true do |t|
    t.integer "resource_id"
    t.integer "tag_id"
  end

  create_table "tags", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "tag_name"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
  end

end
