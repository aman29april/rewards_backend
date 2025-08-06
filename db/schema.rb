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

ActiveRecord::Schema[8.0].define(version: 2025_07_30_054332) do
  create_table "redemptions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "reward_id", null: false
    t.datetime "redeemed_at"
    t.integer "points_spent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reward_id"], name: "index_redemptions_on_reward_id"
    t.index ["user_id"], name: "index_redemptions_on_user_id"
  end

  create_table "reward_histories", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "reward_id", null: false
    t.integer "points_used"
    t.integer "action_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reward_id"], name: "index_reward_histories_on_reward_id"
    t.index ["user_id"], name: "index_reward_histories_on_user_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "cost", null: false
    t.integer "limit"
    t.integer "redemptions_count", default: 0, null: false
    t.datetime "available_from"
    t.datetime "available_until"
    t.boolean "enabled", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["available_from"], name: "index_rewards_on_available_from"
    t.index ["available_until"], name: "index_rewards_on_available_until"
    t.index ["enabled"], name: "index_rewards_on_enabled"
    t.index ["redemptions_count"], name: "index_rewards_on_redemptions_count"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.integer "points_balance", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "redemptions", "rewards"
  add_foreign_key "redemptions", "users"
  add_foreign_key "reward_histories", "rewards"
  add_foreign_key "reward_histories", "users"
end
