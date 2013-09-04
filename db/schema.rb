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

ActiveRecord::Schema.define(version: 20130904205109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collaboration_applications", force: true do |t|
    t.integer  "project_id"
    t.integer  "applicant_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "message"
    t.string   "status",            default: "pending"
    t.string   "active",            default: "yes"
  end

  add_index "collaboration_applications", ["applicant_user_id"], name: "index_collaboration_applications_on_applicant_user_id", using: :btree
  add_index "collaboration_applications", ["project_id"], name: "index_collaboration_applications_on_project_id", using: :btree

  create_table "collaboration_invitations", force: true do |t|
    t.integer  "project_id"
    t.integer  "invited_by_user_id"
    t.integer  "invited_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "active",             default: "yes"
    t.string   "status",             default: "pending"
    t.string   "message"
  end

  add_index "collaboration_invitations", ["invited_by_user_id"], name: "index_collaboration_invitations_on_invited_by_user_id", using: :btree
  add_index "collaboration_invitations", ["invited_user_id"], name: "index_collaboration_invitations_on_invited_user_id", using: :btree
  add_index "collaboration_invitations", ["project_id"], name: "index_collaboration_invitations_on_project_id", using: :btree

  create_table "collaborations", force: true do |t|
    t.string   "role"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collaborations", ["project_id"], name: "index_collaborations_on_project_id", using: :btree
  add_index "collaborations", ["user_id"], name: "index_collaborations_on_user_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["project_id"], name: "index_taggings_on_project_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
