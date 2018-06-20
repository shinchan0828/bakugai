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

ActiveRecord::Schema.define(version: 20180620031703) do

  create_table "commodities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "request_id"
    t.string   "product_name"
    t.integer  "amount"
    t.integer  "price"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["request_id"], name: "fk_rails_8383dfaa2d", using: :btree
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",    limit: 65535
    t.integer  "from_id"
    t.integer  "to_id"
    t.integer  "request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["request_id"], name: "fk_rails_d49f4936e6", using: :btree
  end

  create_table "request_transitions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "to_state",                  null: false
    t.text     "metadata",    limit: 65535
    t.integer  "sort_key",                  null: false
    t.integer  "request_id",                null: false
    t.boolean  "most_recent"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["request_id", "most_recent"], name: "index_request_transitions_parent_most_recent", unique: true, using: :btree
    t.index ["request_id", "sort_key"], name: "index_request_transitions_parent_sort", unique: true, using: :btree
  end

  create_table "requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "budget"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "fk_rails_8ead8b1e6b", using: :btree
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                   default: ""
    t.string   "email",                  default: "",    null: false
    t.string   "profile",                default: ""
    t.string   "image"
    t.boolean  "buyer_flag",             default: false
    t.boolean  "seller_flag",            default: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id", using: :btree
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
    t.index ["user_id"], name: "index_users_roles_on_user_id", using: :btree
  end

  add_foreign_key "commodities", "requests"
  add_foreign_key "messages", "requests"
  add_foreign_key "request_transitions", "requests"
  add_foreign_key "requests", "users"
end
