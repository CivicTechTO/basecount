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

ActiveRecord::Schema.define(version: 2018_07_08_164945) do

  create_table "aspects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "historical_capacities", force: :cascade do |t|
    t.integer "room_id"
    t.integer "recorded_by_id"
    t.datetime "recorded_at"
    t.integer "capacity"
    t.integer "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recorded_by_id"], name: "index_historical_capacities_on_recorded_by_id"
    t.index ["room_id"], name: "index_historical_capacities_on_room_id"
  end

  create_table "orgs", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "population_whitelists", force: :cascade do |t|
    t.integer "code"
    t.integer "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_population_whitelists_on_site_id"
  end

  create_table "roles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "site_id"
    t.integer "org_id"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["org_id"], name: "index_roles_on_org_id"
    t.index ["site_id"], name: "index_roles_on_site_id"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "site_id"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_rooms_on_site_id"
  end

  create_table "schedule_templates", force: :cascade do |t|
    t.integer "site_id"
    t.integer "day_of_week"
    t.integer "open"
    t.integer "close"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_schedule_templates_on_site_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "site_id"
    t.datetime "open"
    t.datetime "close"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_schedules_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "postal_code"
    t.string "description"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.integer "org_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["org_id"], name: "index_sites_on_org_id"
  end

  create_table "sites_aspects", force: :cascade do |t|
    t.integer "site_id"
    t.integer "aspect_id"
    t.index ["aspect_id"], name: "index_sites_aspects_on_aspect_id"
    t.index ["site_id"], name: "index_sites_aspects_on_site_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
