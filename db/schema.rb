# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_29_033422) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'image_tags', force: :cascade do |t|
    t.datetime('created_at', precision: 6, null: false)
    t.datetime('updated_at', precision: 6, null: false)
    t.bigint('image_id')
    t.bigint('tag_id')
    t.index(['image_id'], name: 'index_image_tags_on_image_id')
    t.index(['tag_id'], name: 'index_image_tags_on_tag_id')
  end

  create_table 'images', force: :cascade do |t|
    t.string('title')
    t.text('description')
    t.datetime('created_at', precision: 6, null: false)
    t.datetime('updated_at', precision: 6, null: false)
    t.bigint('user_id')
    t.index(['user_id'], name: 'index_images_on_user_id')
  end

  create_table 'tags', force: :cascade do |t|
    t.string('name')
    t.datetime('created_at', precision: 6, null: false)
    t.datetime('updated_at', precision: 6, null: false)
  end

  create_table 'users', force: :cascade do |t|
    t.string('first_name', null: false)
    t.string('last_name', null: false)
    t.string('email', null: false)
    t.string('password_digest', null: false)
    t.datetime('created_at', precision: 6, null: false)
    t.datetime('updated_at', precision: 6, null: false)
    t.index(['email'], name: 'index_users_on_email', unique: true)
  end

  add_foreign_key 'image_tags', 'images'
  add_foreign_key 'image_tags', 'tags'
  add_foreign_key 'images', 'users'
end
