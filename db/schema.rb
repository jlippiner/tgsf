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

ActiveRecord::Schema.define(:version => 20110713144708) do

  create_table "answers", :force => true do |t|
    t.text     "answer"
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bj_config", :primary_key => "bj_config_id", :force => true do |t|
    t.text "hostname"
    t.text "key"
    t.text "value"
    t.text "cast"
  end

  create_table "bj_job", :primary_key => "bj_job_id", :force => true do |t|
    t.text     "command"
    t.text     "state"
    t.integer  "priority"
    t.text     "tag"
    t.integer  "is_restartable"
    t.text     "submitter"
    t.text     "runner"
    t.integer  "pid"
    t.datetime "submitted_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.text     "env"
    t.text     "stdin"
    t.text     "stdout"
    t.text     "stderr"
    t.integer  "exit_status"
  end

  create_table "bj_job_archive", :primary_key => "bj_job_archive_id", :force => true do |t|
    t.text     "command"
    t.text     "state"
    t.integer  "priority"
    t.text     "tag"
    t.integer  "is_restartable"
    t.text     "submitter"
    t.text     "runner"
    t.integer  "pid"
    t.datetime "submitted_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "archived_at"
    t.text     "env"
    t.text     "stdin"
    t.text     "stdout"
    t.text     "stderr"
    t.integer  "exit_status"
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

  create_table "followers", :force => true do |t|
    t.string   "screen_name"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hih_users", :force => true do |t|
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

  create_table "involvements", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "dates"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_name"
    t.string   "partial_file_name"
    t.string   "campaign"
    t.boolean  "is_active"
    t.boolean  "is_featured"
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

  add_index "jobs", ["priority"], :name => "jobs_priority_idx"
  add_index "jobs", ["start_at"], :name => "jobs_start_at_idx"
  add_index "jobs", ["state"], :name => "jobs_state_idx"

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
    t.integer  "is_personal", :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", :force => true do |t|
    t.string   "zipcode"
    t.string   "twitter_id"
    t.integer  "sent_dm",             :limit => 2
    t.integer  "is_following",        :limit => 2
    t.integer  "number_of_friends"
    t.integer  "number_of_followers"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile_pic_url"
    t.integer  "completed",           :limit => 2
  end

  create_table "unite_donations", :force => true do |t|
    t.integer  "unite_id"
    t.float    "amount"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "donation_type"
    t.string   "message"
    t.datetime "donated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uniters", :force => true do |t|
    t.string   "name"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unites", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "twitter_id"
    t.string   "login"
    t.string   "access_token"
    t.string   "access_secret"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "location"
    t.string   "description"
    t.string   "profile_image_url"
    t.string   "url"
    t.integer  "protected",                    :limit => 2
    t.string   "profile_background_color"
    t.string   "profile_sidebar_fill_color"
    t.string   "profile_link_color"
    t.string   "profile_sidebar_border_color"
    t.string   "profile_text_color"
    t.string   "profile_background_image_url"
    t.integer  "profile_background_tiled",     :limit => 2
    t.integer  "friends_count"
    t.integer  "statuses_count"
    t.integer  "followers_count"
    t.integer  "favourites_count"
    t.integer  "utc_offset"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
