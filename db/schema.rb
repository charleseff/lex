# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 89) do

  create_table "assignment_topics", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignment_topics_grade_levels", :id => false, :force => true do |t|
    t.integer  "assignment_topic_id", :null => false
    t.integer  "grade_level_id",      :null => false
    t.integer  "option"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignment_topics_grade_levels", ["assignment_topic_id"], :name => "index_assignment_topics_grade_levels_on_assignment_topic_id"
  add_index "assignment_topics_grade_levels", ["grade_level_id"], :name => "index_assignment_topics_grade_levels_on_grade_level_id"

  create_table "books", :force => true do |t|
    t.string "title"
    t.string "author"
  end

  add_index "books", ["title"], :name => "index_books_on_title"
  add_index "books", ["author"], :name => "index_books_on_author"

  create_table "confirmation_codes", :force => true do |t|
    t.integer  "user_id"
    t.string   "code"
    t.string   "task"
    t.datetime "created_at"
  end

  create_table "dialog_messages", :force => true do |t|
    t.integer  "report_id"
    t.string   "speaker"
    t.text     "message"
    t.datetime "created_at"
  end

  create_table "docs", :force => true do |t|
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "parent_id"
    t.integer  "width"
    t.integer  "height"
    t.string   "type"
    t.integer  "report_id"
    t.datetime "created_at"
  end

  create_table "email_change_requests", :force => true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "confirmation_code"
    t.datetime "created_at"
  end

  create_table "grade_levels", :force => true do |t|
    t.integer "level"
  end

  add_index "grade_levels", ["level"], :name => "index_grade_levels_on_level"

  create_table "grade_levels_resources", :id => false, :force => true do |t|
    t.integer "grade_level_id", :null => false
    t.integer "resource_id",    :null => false
  end

  add_index "grade_levels_resources", ["grade_level_id"], :name => "index_grade_levels_resources_on_grade_level_id"
  add_index "grade_levels_resources", ["resource_id"], :name => "index_grade_levels_resources_on_resource_id"

  create_table "graded_ptal_task_items", :force => true do |t|
    t.integer "report_id"
    t.integer "ptal_task_item_id"
    t.string  "points_earned"
  end

  create_table "graders_preferred_grade_levels", :id => false, :force => true do |t|
    t.integer  "grade_level_id", :null => false
    t.integer  "grader_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "graders_preferred_grade_levels", ["grader_id"], :name => "index_grade_levels_graders_on_grader_id"

  create_table "grading_failures", :force => true do |t|
    t.integer "grader_id"
    t.integer "report_id"
  end

  add_index "grading_failures", ["report_id"], :name => "index_grading_failures_on_report_id"
  add_index "grading_failures", ["grader_id"], :name => "index_grading_failures_on_grader_id"

  create_table "key_value_pairs", :force => true do |t|
    t.string "k"
    t.string "v"
  end

  create_table "pdfs", :force => true do |t|
    t.string  "filename"
    t.integer "report_id"
  end

  create_table "ptal_task_items", :force => true do |t|
    t.string  "category"
    t.string  "description"
    t.integer "possible_points"
    t.integer "grade_level_id"
    t.integer "display_order"
  end

  create_table "reports", :force => true do |t|
    t.integer  "student_id",                                   :null => false
    t.integer  "grader_id"
    t.integer  "book_id"
    t.text     "grader_comment"
    t.boolean  "grader_was_warned",         :default => false
    t.boolean  "archive_notification_sent", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "graded_at"
    t.datetime "assigned_to_grader_at"
    t.integer  "grade_level_id"
    t.integer  "assignment_topic_id"
    t.datetime "last_saved_by_grader_at"
    t.datetime "grader_doc_updated_at"
    t.boolean  "has_pdf",                   :default => false
    t.boolean  "submitted_for_preview",     :default => false
  end

  add_index "reports", ["grader_id"], :name => "index_reports_on_grader_id"
  add_index "reports", ["grader_was_warned"], :name => "index_reports_on_grader_was_warned"
  add_index "reports", ["created_at"], :name => "index_reports_on_created_at"
  add_index "reports", ["graded_at"], :name => "index_reports_on_graded_at"
  add_index "reports", ["assigned_to_grader_at"], :name => "index_reports_on_assigned_to_grader_at"
  add_index "reports", ["student_id"], :name => "index_reports_on_student_id"

  create_table "resources", :force => true do |t|
    t.string   "name"
    t.string   "subheading"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_name"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.integer  "grade_level_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "type"
    t.date     "birth_date"
    t.boolean  "confirmed",                               :default => false
    t.string   "time_zone"
    t.boolean  "sample",                                  :default => false
  end

end
