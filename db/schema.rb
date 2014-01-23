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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140123152321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "country"
    t.string   "street"
    t.integer  "street_number"
    t.integer  "city_code"
    t.string   "country_code"
    t.boolean  "is_actual",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advertisement_advertisements", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "active"
    t.string   "type"
    t.integer  "user_id"
    t.integer  "book_id_id"
    t.string   "language"
    t.integer  "hits"
    t.decimal  "price",          precision: 9, scale: 2
    t.string   "currency"
    t.string   "delivery_modes"
    t.string   "payment_modes"
    t.string   "state"
    t.string   "annotation"
    t.integer  "study_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "advertisement_advertisements", ["book_id_id"], name: "index_advertisement_advertisements_on_book_id_id", using: :btree
  add_index "advertisement_advertisements", ["study_level_id"], name: "index_advertisement_advertisements_on_study_level_id", using: :btree
  add_index "advertisement_advertisements", ["user_id"], name: "index_advertisement_advertisements_on_user_id", using: :btree

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "authors"
    t.string   "publisher"
    t.date     "published_date"
    t.text     "description"
    t.string   "isbn_10"
    t.string   "isbn_13"
    t.integer  "page_count"
    t.float    "average_rating"
    t.integer  "ratings_count"
    t.string   "language"
    t.string   "preview_link"
    t.string   "info_link"
    t.string   "image_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["owner_id", "owner_type"], name: "index_comments_on_owner_id_and_owner_type", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "subject"
    t.string   "email"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "document_documents", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "author"
    t.integer  "number_of_pages"
    t.date     "realized_at"
    t.string   "language"
    t.boolean  "is_accepted",     default: false
    t.string   "status",          default: "pending"
    t.integer  "hits",            default: 0
    t.boolean  "is_deleted",      default: false
    t.string   "study_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_documents_domains", id: false, force: true do |t|
    t.integer "document_document_id", null: false
    t.integer "domain_id",            null: false
  end

  create_table "document_downloads", force: true do |t|
    t.integer  "user_id"
    t.integer  "document_documents_id"
    t.integer  "number_of_downloads"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_type_translations", force: true do |t|
    t.integer  "document_type_id", null: false
    t.string   "locale",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
  end

  add_index "document_type_translations", ["document_type_id"], name: "index_document_type_translations_on_document_type_id", using: :btree
  add_index "document_type_translations", ["locale"], name: "index_document_type_translations_on_locale", using: :btree

  create_table "document_types", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "domain_translations", force: true do |t|
    t.integer  "domain_id",   null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
  end

  add_index "domain_translations", ["domain_id"], name: "index_domain_translations_on_domain_id", using: :btree
  add_index "domain_translations", ["locale"], name: "index_domain_translations_on_locale", using: :btree

  create_table "domains", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "ancestry"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_groups", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "password_confirmation"
    t.string   "type"
    t.string   "can_index_members"
    t.string   "can_read_member"
    t.string   "can_delete_member"
    t.string   "can_write_file"
    t.string   "can_index_files"
    t.string   "can_read_file"
    t.string   "can_delete_file"
    t.string   "can_index_statuses"
    t.string   "can_write_status"
    t.string   "can_delete_status"
    t.string   "can_create_invitation"
    t.string   "can_manage_invitations"
    t.text     "description"
    t.integer  "group_groups_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_groups_group_members", force: true do |t|
    t.integer  "group_groups_id"
    t.integer  "group_members_id"
    t.string   "group_members_type"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_groups_group_members", ["group_groups_id"], name: "index_group_groups_group_members_on_group_groups_id", using: :btree
  add_index "group_groups_group_members", ["group_members_id"], name: "group_member_index", using: :btree

  create_table "group_invitations", force: true do |t|
    t.integer  "user_users_id"
    t.integer  "group_groups_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_invitations", ["group_groups_id"], name: "index_group_invitations_on_group_groups_id", using: :btree
  add_index "group_invitations", ["user_users_id"], name: "index_group_invitations_on_user_users_id", using: :btree

  create_table "group_invitations_user_users", id: false, force: true do |t|
    t.integer "group_invitation_id", null: false
    t.integer "user_user_id",        null: false
  end

  create_table "guest_books", force: true do |t|
    t.string   "name"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "member_contacts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "gender"
    t.integer  "users_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "member_contacts", ["users_id"], name: "index_member_contacts_on_users_id", using: :btree

  create_table "member_friend_demands", force: true do |t|
    t.text     "message"
    t.integer  "user_has_sent_id"
    t.integer  "user_is_invited_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "member_friend_friends", force: true do |t|
    t.integer  "users_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "member_friend_friends", ["users_id"], name: "index_member_friend_friends_on_users_id", using: :btree

  create_table "member_studies", force: true do |t|
    t.date     "started_at"
    t.date     "ended_at"
    t.string   "orientation"
    t.integer  "users_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "member_studies", ["users_id"], name: "index_member_studies_on_users_id", using: :btree

  create_table "member_users_addresses", force: true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "addresses_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "member_users_addresses", ["owner_id", "owner_type"], name: "index_member_users_addresses_on_owner_id_and_owner_type", using: :btree

  create_table "messages", force: true do |t|
    t.text     "body"
    t.string   "subject",         default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",           default: false
    t.datetime "updated_at",                      null: false
    t.datetime "created_at",                      null: false
    t.string   "attachment"
    t.boolean  "global",          default: false
    t.datetime "expires"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree

  create_table "rates", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "message_id",                               null: false
    t.boolean  "is_read",                  default: false
    t.boolean  "trashed",                  default: false
    t.boolean  "deleted",                  default: false
    t.string   "mailbox_type",  limit: 25
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "receipts", ["message_id"], name: "index_receipts_on_message_id", using: :btree

  create_table "repo_items", force: true do |t|
    t.integer "owner_id"
    t.string  "owner_type"
    t.string  "ancestry"
    t.string  "name"
    t.float   "file_size"
    t.string  "content_type"
    t.string  "file"
    t.string  "type"
  end

  create_table "sharings", force: true do |t|
    t.integer "owner_id"
    t.string  "owner_type"
    t.integer "repo_item_id"
    t.boolean "can_create",   default: false
    t.boolean "can_read",     default: false
    t.boolean "can_update",   default: false
    t.boolean "can_delete",   default: false
    t.boolean "can_share",    default: false
  end

  create_table "sharings_members", force: true do |t|
    t.integer "sharing_id"
    t.integer "member_id"
    t.string  "member_type"
    t.boolean "can_add",     default: false
    t.boolean "can_remove",  default: false
  end

  create_table "statuses", force: true do |t|
    t.text     "message"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statuses", ["owner_id", "owner_type"], name: "index_statuses_on_owner_id_and_owner_type", using: :btree

  create_table "user_messages", force: true do |t|
    t.text   "body"
    t.string "subject"
  end

  create_table "user_messages_users", id: false, force: true do |t|
    t.integer "user_id",         null: false
    t.integer "user_message_id", null: false
  end

  create_table "user_notifications", force: true do |t|
    t.string   "class_name"
    t.string   "method_name"
    t.string   "values"
    t.boolean  "is_viewed",   default: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "name"
    t.string   "role"
    t.integer  "points",                 default: 5
    t.boolean  "has_notifications",      default: false
    t.string   "provider"
    t.string   "uid"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "messages", "conversations", name: "notifications_on_conversation_id"

  add_foreign_key "receipts", "messages", name: "receipts_on_notification_id"

end
