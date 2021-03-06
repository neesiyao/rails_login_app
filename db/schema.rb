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

ActiveRecord::Schema.define(version: 20141112075439) do

  create_table "invitations", force: true do |t|
    t.string   "email"
    t.integer  "quiz_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sender_name"
    t.string   "end_time"
    t.string   "quiz_answer_file_name"
    t.string   "quiz_answer_content_type"
    t.integer  "quiz_answer_file_size"
    t.datetime "quiz_answer_updated_at"
  end

  add_index "invitations", ["quiz_id", "created_at"], name: "index_invitations_on_quiz_id_and_created_at"
  add_index "invitations", ["quiz_id"], name: "index_invitations_on_quiz_id"

# Could not dump table "quizzes" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.boolean  "examiner",        default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
