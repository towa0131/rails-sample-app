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

ActiveRecord::Schema[7.1].define(version: 2024_05_10_063442) do
  create_table "follow_relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_follow_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_follow_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_follow_relationships_on_follower_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.text "image"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "email"
    t.string "nickname"
    t.string "name"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bio"
    t.string "vid"
  end

end
