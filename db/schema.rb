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

ActiveRecord::Schema.define(version: 2019_07_04_102059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercise_details", force: :cascade do |t|
    t.string "detail"
    t.integer "calories"
    t.integer "exercise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercise_types", force: :cascade do |t|
    t.string "detail"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.string "detail"
    t.datetime "exercise_date"
    t.integer "user_id"
    t.integer "exercise_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meal_details", force: :cascade do |t|
    t.string "detail"
    t.integer "calories"
    t.integer "meal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meal_types", force: :cascade do |t|
    t.string "detail"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meals", force: :cascade do |t|
    t.string "detail"
    t.integer "user_id"
    t.datetime "meal_date"
    t.integer "meal_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "password_digest"
    t.string "email"
    t.string "name"
    t.datetime "dob"
    t.integer "height_cm"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weights", force: :cascade do |t|
    t.integer "user_id"
    t.float "weight_kg"
    t.datetime "weight_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
