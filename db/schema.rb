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

ActiveRecord::Schema.define(version: 20180309000602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "anonymized_connections", force: :cascade do |t|
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.string   "telephone_number"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["telephone_number"], name: "index_anonymized_connections_on_telephone_number", using: :btree
    t.index ["user1_id"], name: "index_anonymized_connections_on_user1_id", using: :btree
    t.index ["user2_id"], name: "index_anonymized_connections_on_user2_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "telephone_number"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["telephone_number"], name: "index_users_on_telephone_number", using: :btree
  end

  add_foreign_key "anonymized_connections", "users", column: "user1_id"
  add_foreign_key "anonymized_connections", "users", column: "user2_id"
end
