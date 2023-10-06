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

ActiveRecord::Schema[7.0].define(version: 20_231_003_115_033) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'diagnoses', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'keyboard_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['keyboard_id'], name: 'index_diagnoses_on_keyboard_id'
    t.index ['user_id'], name: 'index_diagnoses_on_user_id'
  end

  create_table 'keyboard_tags', force: :cascade do |t|
    t.bigint 'keyboard_id', null: false
    t.bigint 'tag_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['keyboard_id'], name: 'index_keyboard_tags_on_keyboard_id'
    t.index ['tag_id'], name: 'index_keyboard_tags_on_tag_id'
  end

  create_table 'keyboards', force: :cascade do |t|
    t.string 'name'
    t.string 'brand'
    t.integer 'price'
    t.string 'layout'
    t.string 'size'
    t.string 'switch'
    t.string 'url'
    t.string 'os', default: [], array: true
    t.string 'medium_image_urls', default: [], array: true
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.text 'caption'
    t.string 'connect', default: [], array: true
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email', null: false
    t.string 'crypted_password'
    t.string 'salt'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'role', default: 0, null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'diagnoses', 'keyboards'
  add_foreign_key 'diagnoses', 'users'
  add_foreign_key 'keyboard_tags', 'keyboards'
  add_foreign_key 'keyboard_tags', 'tags'
end
