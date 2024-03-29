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

ActiveRecord::Schema.define(:version => 20120305053810) do

  create_table "meetup_events", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetup_members", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.text     "unparsed_json"
    t.string   "image_url"
    t.string   "linkedin_url"
    t.string   "twitter"
    t.integer  "meetup_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetup_topics", :force => true do |t|
    t.string   "urlkey"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "meetup_id"
  end

  create_table "twitter_members", :force => true do |t|
    t.integer  "user_id"
    t.string   "screenname"
    t.integer  "twitter_id"
    t.text     "followers"
    t.text     "following"
    t.text     "categories"
    t.string   "profile_image_url"
    t.string   "location"
    t.string   "name"
    t.string   "description"
    t.boolean  "verified"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "followers_count"
    t.integer  "following_count"
  end

  create_table "user_affinities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "target_user_id"
    t.integer  "t_meetup_member_id"
    t.string   "meetup_topics_in_common"
    t.integer  "affinity_score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "linked_in"
    t.boolean  "twitter"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
