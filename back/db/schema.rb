# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_01_053542) do
  create_table "organization_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "user_id"], name: "index_organization_users_on_organization_id_and_user_id", unique: true
    t.index ["organization_id"], name: "index_organization_users_on_organization_id"
    t.index ["user_id"], name: "index_organization_users_on_user_id"
  end

  create_table "organizations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "github_username", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["github_username"], name: "index_organizations_on_github_username", unique: true
  end

  create_table "teches", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.bigint "parent_id"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_teches_on_discarded_at"
    t.index ["parent_id"], name: "index_teches_on_parent_id"
  end

  create_table "portfolios", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "organization_id"
    t.string "name", limit: 50, null: false
    t.string "url", null: false
    t.text "introduction"
    t.integer "unhealthy_cnt", limit: 1, default: 0
    t.datetime "latest_health_check_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_portfolios_on_organization_id"
    t.index ["url"], name: "index_portfolios_on_url", unique: true
    t.index ["user_id"], name: "index_portfolios_on_user_id"
  end

  create_table "test_posts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_teches", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tech_id", null: false
    t.integer "exp_months_job", limit: 1
    t.integer "exp_months_hobby", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tech_id"], name: "index_user_teches_on_tech_id"
    t.index ["user_id", "tech_id"], name: "index_user_teches_on_user_id_and_tech_id", unique: true
    t.index ["user_id"], name: "index_user_teches_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "github_username", limit: 50
    t.string "auth0_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["github_username"], name: "index_users_on_github_username", unique: true
  end

  add_foreign_key "organization_users", "organizations"
  add_foreign_key "organization_users", "users"
  add_foreign_key "teches", "teches", column: "parent_id"
  add_foreign_key "user_teches", "teches"
  add_foreign_key "user_teches", "users"
  add_foreign_key "portfolios", "organizations"
  add_foreign_key "portfolios", "users"
end
