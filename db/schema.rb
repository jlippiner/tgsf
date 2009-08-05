# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090805213225) do

  create_table "answers", :force => true do |t|
    t.text     "answer"
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donations", :force => true do |t|
    t.string   "name"
    t.string   "campaign"
    t.string   "location"
    t.datetime "donation_date"
    t.integer  "amount",        :limit => 10, :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "highlight"
  end

  create_table "jobs", :force => true do |t|
    t.string   "worker_class"
    t.string   "worker_method"
    t.text     "args"
    t.text     "result"
    t.integer  "priority"
    t.integer  "progress"
    t.string   "state"
    t.integer  "lock_version",  :default => 0
    t.datetime "start_at"
    t.datetime "started_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jobs", ["priority"], :name => "index_jobs_on_priority"
  add_index "jobs", ["start_at"], :name => "index_jobs_on_start_at"
  add_index "jobs", ["state"], :name => "index_jobs_on_state"

  create_table "presses", :force => true do |t|
    t.string   "item"
    t.string   "source"
    t.date     "story_date_at"
    t.string   "link"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "question"
    t.boolean  "is_personal", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", :force => true do |t|
    t.string   "zipcode"
    t.string   "twitter_id"
    t.boolean  "sent_dm"
    t.boolean  "is_following"
    t.integer  "number_of_friends"
    t.integer  "number_of_followers"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "survey_number"
    t.text     "thoughts"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "disease"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "diagnosis_month"
    t.integer  "diagnosis_year"
    t.string   "relation_to_disease"
  end

end
