ActiveRecord::Schema[7.0].define(version: 2023_11_03_021417) do
  enable_extension "plpgsql"

  # モデルをblobsに接続するポリモーフィックjoinテーブルです。モデルのクラス名が変更された場合は、このテーブルでマイグレーションを実行して、背後のrecord_typeをモデルの新しいクラス名に更新する必要があります。
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  # アップロードされたファイルに関するデータ（ファイル名、Content-Typeなど）を保存します。
  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  # バリアントトラッキングが有効な場合は、生成された各バリアントに関するレコードを保存します。
  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "keyboard_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["keyboard_id"], name: "index_bookmarks_on_keyboard_id"
    t.index ["user_id", "keyboard_id"], name: "index_bookmarks_on_user_id_and_keyboard_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.bigint "keyboard_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["keyboard_id"], name: "index_comments_on_keyboard_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "subject", null: false
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diagnoses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "keyboard_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["keyboard_id"], name: "index_diagnoses_on_keyboard_id"
    t.index ["user_id"], name: "index_diagnoses_on_user_id"
  end

  create_table "keyboard_tags", force: :cascade do |t|
    t.bigint "keyboard_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["keyboard_id"], name: "index_keyboard_tags_on_keyboard_id"
    t.index ["tag_id"], name: "index_keyboard_tags_on_tag_id"
  end

  create_table "keyboards", force: :cascade do |t|
    t.string "name"
    t.string "brand"
    t.integer "price"
    t.string "layout"
    t.string "size"
    t.string "switch"
    t.string "url"
    t.string "os", default: [], array: true
    t.string "medium_image_urls", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "caption"
    t.string "connect", default: [], array: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookmarks", "keyboards"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "comments", "keyboards"
  add_foreign_key "comments", "users"
  add_foreign_key "diagnoses", "keyboards"
  add_foreign_key "diagnoses", "users"
  add_foreign_key "keyboard_tags", "keyboards"
  add_foreign_key "keyboard_tags", "tags"
end
