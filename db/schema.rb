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

ActiveRecord::Schema[7.0].define(version: 2023_04_04_033426) do
  create_table "chats", force: :cascade do |t|
    t.integer "room_id"
    t.integer "room_guest_id"
    t.integer "guest_id"
    t.text "remark", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_chats_on_guest_id"
    t.index ["room_guest_id"], name: "index_chats_on_room_guest_id"
    t.index ["room_id"], name: "index_chats_on_room_id"
  end

  create_table "guests", force: :cascade do |t|
    t.string "CreateGuests"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "room_guests", force: :cascade do |t|
    t.integer "room_id"
    t.integer "guest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_room_guests_on_guest_id"
    t.index ["room_id"], name: "index_room_guests_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_rooms_on_owner_id"
  end

  add_foreign_key "chats", "guests"
  add_foreign_key "chats", "room_guests"
  add_foreign_key "chats", "rooms"
  add_foreign_key "room_guests", "guests"
  add_foreign_key "room_guests", "rooms"
  add_foreign_key "rooms", "guests", column: "owner_id"
end
