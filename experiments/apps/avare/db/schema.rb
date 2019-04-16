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

ActiveRecord::Schema.define(:version => 20110821183443) do

  create_table "categories", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "specification_logs", :force => true do |t|
    t.integer  "specification_id"
    t.string   "entity"
    t.string   "unit"
    t.float    "quantity"
    t.float    "price_with_vat"
    t.float    "coast_of_delivery"
    t.integer  "category_id"
    t.string   "supplier"
    t.integer  "project_id"
    t.string   "notice"
    t.string   "recommended_conditions"
    t.string   "recommended_supplier"
    t.string   "recommended_notice"
    t.integer  "contractor_id"
    t.integer  "controller_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "specifications", :force => true do |t|
    t.string   "entity"
    t.string   "unit"
    t.float    "quantity"
    t.float    "price_with_vat"
    t.float    "coast_of_delivery"
    t.integer  "category_id"
    t.string   "supplier"
    t.integer  "project_id"
    t.string   "notice"
    t.string   "recommended_conditions"
    t.string   "recommended_supplier"
    t.string   "recommended_notice"
    t.integer  "contractor_id"
    t.integer  "controller_id"
    t.string   "state"
    t.datetime "state_switched_at"
    t.integer  "studying_duration"
    t.integer  "approving_duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", :force => true do |t|
    t.string   "entity"
    t.string   "unit"
    t.float    "quantity"
    t.float    "price_with_vat"
    t.float    "coast_of_delivery"
    t.string   "supplier"
    t.string   "master_project"
    t.string   "slave_project"
    t.integer  "contractor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "roles_mask"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
