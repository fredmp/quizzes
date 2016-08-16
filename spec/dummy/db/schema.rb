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

ActiveRecord::Schema.define(version: 20160816213825) do

  create_table "quizzes_answers", force: :cascade do |t|
    t.string   "text"
    t.integer  "question_id"
    t.boolean  "correct"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_quizzes_answers_on_question_id"
  end

  create_table "quizzes_game_questions", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "question_id"
    t.integer  "seed_to_shuffle_answers"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["game_id"], name: "index_quizzes_game_questions_on_game_id"
    t.index ["question_id"], name: "index_quizzes_game_questions_on_question_id"
  end

  create_table "quizzes_games", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "level_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level_id"], name: "index_quizzes_games_on_level_id"
    t.index ["user_id"], name: "index_quizzes_games_on_user_id"
  end

  create_table "quizzes_levels", force: :cascade do |t|
    t.integer  "number_of_questions"
    t.string   "name"
    t.string   "code"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "quizzes_questions", force: :cascade do |t|
    t.string   "text"
    t.integer  "level_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level_id"], name: "index_quizzes_questions_on_level_id"
  end

  create_table "quizzes_users", force: :cascade do |t|
    t.string   "name"
    t.string   "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
