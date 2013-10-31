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

ActiveRecord::Schema.define(:version => 20131031184406) do

  create_table "comment_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.string   "vote"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "comment_id"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "upvotes",      :default => 0
    t.integer  "downvotes",    :default => 0
    t.float    "score",        :default => 0.0
    t.integer  "spam_count",   :default => 0
    t.text     "comment_text"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "interactions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "comment_id"
    t.integer  "comment_vote_id"
    t.integer  "post_vote_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "post_and_topic_pairings", :force => true do |t|
    t.integer  "post_id"
    t.integer  "topic_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "post_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.string   "vote"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "post_type"
    t.string   "title"
    t.string   "link"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "post_id"
    t.string   "status",     :default => "draft"
    t.integer  "upvotes",    :default => 0
    t.integer  "downvotes",  :default => 0
    t.float    "score",      :default => 0.0
    t.integer  "spam_count", :default => 0
    t.string   "slug",       :default => "untitled"
    t.integer  "user_id"
    t.text     "text"
  end

  create_table "postviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "social_messages", :force => true do |t|
    t.integer  "user_id"
    t.text     "message_text"
    t.string   "message_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "post_id"
    t.integer  "comment_id"
  end

  create_table "spams", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "comment_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "topic_follows", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.boolean  "manual_follow"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "topic_pairings", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "child_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "topics", :force => true do |t|
    t.string   "topic_name"
    t.integer  "user_id"
    t.boolean  "featured",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "email"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "screen_name"
    t.string   "profile_picture"
    t.string   "bio"
    t.string   "oauth_secret"
    t.boolean  "follow_twitter"
  end

end
