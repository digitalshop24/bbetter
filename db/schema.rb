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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160620101633) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "galleries", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "galleries", ["user_id"], name: "index_galleries_on_user_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.integer  "gallery_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "images", ["gallery_id"], name: "index_images_on_gallery_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "text"
    t.integer  "message_type", default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "subscription_types", force: :cascade do |t|
    t.string  "name",                       null: false
    t.string  "key",                        null: false
    t.boolean "active",      default: true, null: false
    t.text    "email_text"
    t.text    "sms_text"
    t.text    "phone_text"
    t.float   "periodicity", default: 0.0,  null: false
  end

  add_index "subscription_types", ["key"], name: "index_subscription_types_on_key", using: :btree
  add_index "subscription_types", ["name"], name: "index_subscription_types_on_name", using: :btree

# Could not dump table "subscriptions" because of following StandardError
#   Unknown type 'channel' for column 'channel'

  create_table "summaries", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "before_file_name"
    t.string   "before_content_type"
    t.integer  "before_file_size"
    t.datetime "before_updated_at"
    t.string   "after_file_name"
    t.string   "after_content_type"
    t.integer  "after_file_size"
    t.datetime "after_updated_at"
    t.string   "motivation_file_name"
    t.string   "motivation_content_type"
    t.integer  "motivation_file_size"
    t.datetime "motivation_updated_at"
    t.integer  "weight"
    t.integer  "height"
    t.integer  "age"
    t.integer  "chest"
    t.integer  "waist"
    t.integer  "thigh"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "motivation_words"
  end

  add_index "summaries", ["user_id"], name: "index_summaries_on_user_id", using: :btree

  create_table "tariffs", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "people_number"
    t.text     "short_content"
    t.text     "full_content"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "additional_image_file_name"
    t.string   "additional_image_content_type"
    t.integer  "additional_image_file_size"
    t.datetime "additional_image_updated_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "user_tariffs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tariff_id"
    t.integer  "status",     default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "user_tariffs", ["tariff_id"], name: "index_user_tariffs_on_tariff_id", using: :btree
  add_index "user_tariffs", ["user_id"], name: "index_user_tariffs_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "auth_token"
    t.string   "name"
    t.string   "city"
    t.integer  "age"
    t.integer  "sex"
    t.text     "motivation"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "youtube_code"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "day"
  end

  add_index "videos", ["user_id"], name: "index_videos_on_user_id", using: :btree

  add_foreign_key "galleries", "users"
  add_foreign_key "images", "galleries"
  add_foreign_key "messages", "users"
  add_foreign_key "subscriptions", "subscription_types"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "summaries", "users"
  add_foreign_key "user_tariffs", "tariffs"
  add_foreign_key "user_tariffs", "users"
  add_foreign_key "videos", "users"
end
