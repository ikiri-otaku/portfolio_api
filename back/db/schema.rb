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

ActiveRecord::Schema[7.1].define(version: 2024_06_16_035836) do
  create_table "github_repositories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "portfolio_id", null: false
    t.string "owner", limit: 50, null: false
    t.string "repo", limit: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["portfolio_id"], name: "index_github_repositories_on_portfolio_id", unique: true
  end

ActiveRecord::Schema[7.1].define(version: 2024_07_29_021322) do
  create_table "likes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "portfolio_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_likes_on_discarded_at"
    t.index ["portfolio_id"], name: "index_likes_on_portfolio_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

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

  create_table "portfolio_teches", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "portfolio_id", null: false
    t.bigint "tech_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["portfolio_id", "tech_id"], name: "index_portfolio_teches_on_portfolio_id_and_tech_id", unique: true
    t.index ["portfolio_id"], name: "index_portfolio_teches_on_portfolio_id"
    t.index ["tech_id"], name: "index_portfolio_teches_on_tech_id"
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

  create_table "teches", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.bigint "parent_id"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_teches_on_discarded_at"
    t.index ["parent_id"], name: "index_teches_on_parent_id"
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
  add_foreign_key "portfolio_teches", "portfolios"
  add_foreign_key "portfolio_teches", "teches"
  add_foreign_key "portfolios", "organizations"
  add_foreign_key "portfolios", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "teches", "teches", column: "parent_id"
  add_foreign_key "user_teches", "teches"
  add_foreign_key "user_teches", "users"
end
