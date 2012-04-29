# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120429020038) do

  create_table "challenges", :force => true do |t|
    t.integer  "challenger_id"
    t.integer  "challengee_id"
    t.string   "message"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "challenges", ["challengee_id"], :name => "index_challenges_on_challengee_id"
  add_index "challenges", ["challenger_id"], :name => "index_challenges_on_challenger_id"

  create_table "games", :force => true do |t|
    t.integer  "word_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "masked_word"
    t.integer  "winner_id"
    t.integer  "current_player_id"
  end

  add_index "games", ["current_player_id"], :name => "index_games_on_current_player_id"
  add_index "games", ["winner_id"], :name => "index_games_on_winner_id"
  add_index "games", ["word_id"], :name => "index_games_on_word_id"

  create_table "guesses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.string   "letter"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "hit"
  end

  add_index "guesses", ["game_id"], :name => "index_guesses_on_game_id"
  add_index "guesses", ["user_id"], :name => "index_guesses_on_user_id"

  create_table "plays", :force => true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "score",      :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "plays", ["game_id"], :name => "index_plays_on_game_id"
  add_index "plays", ["user_id"], :name => "index_plays_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",        :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",        :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.date     "birthdate"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.string   "status",                                :default => "offline", :null => false
    t.datetime "deleted_at"
    t.boolean  "admin",                                 :default => false,     :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["status"], :name => "index_users_on_status"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "words", :force => true do |t|
    t.string   "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "meaning"
  end

end
