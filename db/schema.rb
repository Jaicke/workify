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

ActiveRecord::Schema.define(version: 2022_03_12_235146) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "approvals", force: :cascade do |t|
    t.integer "teacher_id"
    t.integer "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "data_fingerprint"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "colleges", force: :cascade do |t|
    t.string "name"
    t.string "acronym"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["acronym"], name: "index_colleges_on_acronym"
    t.index ["name"], name: "index_colleges_on_name"
    t.index ["state"], name: "index_colleges_on_state"
  end

  create_table "colleges_teacher_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "college_id"
    t.index ["college_id"], name: "index_colleges_teacher_users_on_college_id"
    t.index ["user_id"], name: "index_colleges_teacher_users_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.string "created_by_type"
    t.bigint "created_by_id"
    t.integer "parent_id"
    t.boolean "edited", default: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["created_by_type", "created_by_id"], name: "index_comments_on_created_by_type_and_created_by_id"
  end

  create_table "connections", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "teacher_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_connections_on_student_id"
    t.index ["teacher_id"], name: "index_connections_on_teacher_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_courses_on_name"
  end

  create_table "courses_teacher_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.index ["course_id"], name: "index_courses_teacher_users_on_course_id"
    t.index ["user_id"], name: "index_courses_teacher_users_on_user_id"
  end

  create_table "discussion_answers", force: :cascade do |t|
    t.text "content"
    t.integer "discussion_id"
    t.string "created_by_type"
    t.bigint "created_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_type", "created_by_id"], name: "index_discussion_answers_on_created_by_type_and_created_by_id"
  end

  create_table "discussions", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.boolean "closed", default: false
    t.string "tags", default: [], array: true
    t.integer "work_id"
    t.string "created_by_type"
    t.bigint "created_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_type", "created_by_id"], name: "index_discussions_on_created_by_type_and_created_by_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "event_date"
    t.boolean "online", default: false
    t.string "room_url"
    t.string "place"
    t.string "color"
    t.integer "work_id"
    t.string "created_by_type"
    t.bigint "created_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_type", "created_by_id"], name: "index_events_on_created_by_type_and_created_by_id"
  end

  create_table "group_members", force: :cascade do |t|
    t.integer "work_id"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.string "user_type"
    t.bigint "user_id"
    t.string "likeable_type"
    t.bigint "likeable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id"
    t.index ["user_type", "user_id"], name: "index_likes_on_user_type_and_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "user_type"
    t.bigint "user_id"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.string "notifiable_type"
    t.bigint "notifiable_id"
    t.integer "action"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient_type_and_recipient_id"
    t.index ["user_type", "user_id"], name: "index_notifications_on_user_type_and_user_id"
  end

  create_table "review_events", force: :cascade do |t|
    t.integer "review_id"
    t.integer "action"
    t.string "by_user_type"
    t.bigint "by_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["by_user_type", "by_user_id"], name: "index_review_events_on_by_user_type_and_by_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "status"
    t.string "creation_number"
    t.boolean "confirmed"
    t.integer "work_id"
    t.integer "created_by_id"
    t.integer "old_work_version_id"
    t.integer "new_work_version_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.integer "college_id"
    t.integer "course_id"
    t.integer "class_shift"
    t.integer "ingress_year"
    t.integer "ingress_semester"
    t.integer "serie"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.index ["class_shift"], name: "index_student_users_on_class_shift"
    t.index ["college_id"], name: "index_student_users_on_college_id"
    t.index ["course_id"], name: "index_student_users_on_course_id"
    t.index ["email"], name: "index_student_users_on_email"
    t.index ["first_name"], name: "index_student_users_on_first_name"
    t.index ["ingress_semester"], name: "index_student_users_on_ingress_semester"
    t.index ["ingress_year"], name: "index_student_users_on_ingress_year"
    t.index ["last_name"], name: "index_student_users_on_last_name"
    t.index ["serie"], name: "index_student_users_on_serie"
  end

  create_table "teacher_users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "whatsapp"
    t.text "interests"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
  end

  create_table "teacher_users_works", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "work_id"
    t.index ["user_id"], name: "index_teacher_users_works_on_user_id"
    t.index ["work_id"], name: "index_teacher_users_works_on_work_id"
  end

  create_table "work_versions", force: :cascade do |t|
    t.integer "work_id"
    t.string "title"
    t.integer "created_by_id"
    t.boolean "current", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "works", force: :cascade do |t|
    t.string "theme"
    t.text "description"
    t.integer "status", default: 0
    t.boolean "group", default: false
    t.integer "created_by_id"
    t.integer "advisor_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_works_on_status"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "connections", "student_users", column: "student_id"
  add_foreign_key "connections", "teacher_users", column: "teacher_id"
end
