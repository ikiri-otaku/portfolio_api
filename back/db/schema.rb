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

ActiveRecord::Schema[7.1].define(version: 2024_05_14_154557) do
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

  create_table "profiles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "introduction"
    t.string "location"
    t.string "company"
    t.boolean "hireable", default: true, null: false
    t.string "work_location"
    t.string "x_username", limit: 50
    t.string "zenn_username", limit: 50
    t.string "qiita_username", limit: 50
    t.string "atcoder_username", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["atcoder_username"], name: "index_profiles_on_atcoder_username", unique: true
    t.index ["qiita_username"], name: "index_profiles_on_qiita_username", unique: true
    t.index ["user_id"], name: "index_profiles_on_user_id", unique: true
    t.index ["x_username"], name: "index_profiles_on_x_username", unique: true
    t.index ["zenn_username"], name: "index_profiles_on_zenn_username", unique: true
  end

  create_table "test_posts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "github_username", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["github_username"], name: "index_users_on_github_username", unique: true
  end

  add_foreign_key "organization_users", "organizations"
  add_foreign_key "organization_users", "users"
  add_foreign_key "profiles", "users"
end
