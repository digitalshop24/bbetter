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

ActiveRecord::Schema.define(version: 20160729172518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "theme"
    t.text     "message"
    t.string   "sender_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

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

  create_table "lightnings", force: :cascade do |t|
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "status"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "text"
    t.integer  "message_type", default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "theme"
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "topic_id"
  end

  add_index "posts", ["topic_id"], name: "index_posts_on_topic_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "promocodes", force: :cascade do |t|
    t.string   "code",         null: false
    t.integer  "user_id"
    t.datetime "activated_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "referrer_id"
  end

  add_index "promocodes", ["user_id"], name: "index_promocodes_on_user_id", using: :btree

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
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "motivation_words"
    t.string   "before_front_file_name"
    t.string   "before_front_content_type"
    t.integer  "before_front_file_size"
    t.datetime "before_front_updated_at"
    t.string   "before_back_file_name"
    t.string   "before_back_content_type"
    t.integer  "before_back_file_size"
    t.datetime "before_back_updated_at"
    t.string   "before_left_file_name"
    t.string   "before_left_content_type"
    t.integer  "before_left_file_size"
    t.datetime "before_left_updated_at"
    t.string   "before_right_file_name"
    t.string   "before_right_content_type"
    t.integer  "before_right_file_size"
    t.datetime "before_right_updated_at"
    t.string   "after_front_file_name"
    t.string   "after_front_content_type"
    t.integer  "after_front_file_size"
    t.datetime "after_front_updated_at"
    t.string   "after_back_file_name"
    t.string   "after_back_content_type"
    t.integer  "after_back_file_size"
    t.datetime "after_back_updated_at"
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

  create_table "topics", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "training_programs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_tariffs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tariff_id"
    t.integer  "status",              default: 0, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "training_program_id"
  end

  add_index "user_tariffs", ["tariff_id"], name: "index_user_tariffs_on_tariff_id", using: :btree
  add_index "user_tariffs", ["training_program_id"], name: "index_user_tariffs_on_training_program_id", using: :btree
  add_index "user_tariffs", ["user_id"], name: "index_user_tariffs_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "auth_token"
    t.string   "name"
    t.string   "city"
    t.integer  "age"
    t.integer  "sex"
    t.text     "motivation"
    t.string   "moto"
    t.string   "phone"
    t.boolean  "subscribed",             default: true, null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
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
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "day"
    t.integer  "week"
  end

  add_index "videos", ["user_id"], name: "index_videos_on_user_id", using: :btree

  add_foreign_key "galleries", "users"
  add_foreign_key "images", "galleries"
  add_foreign_key "messages", "users"
  add_foreign_key "promocodes", "users"
  add_foreign_key "promocodes", "users", column: "referrer_id"
  add_foreign_key "subscriptions", "subscription_types"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "summaries", "users"
  add_foreign_key "user_tariffs", "tariffs"
  add_foreign_key "user_tariffs", "training_programs"
  add_foreign_key "user_tariffs", "users"
  add_foreign_key "videos", "users"
end
