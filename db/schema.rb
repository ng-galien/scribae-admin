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

ActiveRecord::Schema.define(version: 20180409062444) do

  create_table "albums", force: :cascade do |t|
    t.integer "website_id"
    t.integer "helper"
    t.integer "pos"
    t.string "title"
    t.string "intro"
    t.boolean "extern"
    t.string "link"
    t.text "markdown"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["website_id"], name: "index_albums_on_website_id"
  end

  create_table "articles", force: :cascade do |t|
    t.integer "website_id"
    t.integer "helper"
    t.boolean "fake"
    t.datetime "date"
    t.boolean "featured"
    t.string "title"
    t.string "intro"
    t.text "markdown"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["website_id"], name: "index_articles_on_website_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "catorizable_type"
    t.integer "catorizable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["catorizable_type", "catorizable_id"], name: "index_categories_on_catorizable_type_and_catorizable_id"
  end

  create_table "components", force: :cascade do |t|
    t.integer "website_id"
    t.string "name"
    t.boolean "show"
    t.integer "pos"
    t.string "icon"
    t.string "icon_color"
    t.string "theme"
    t.string "title"
    t.string "intro"
    t.boolean "show_markdown"
    t.text "markdown"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["website_id"], name: "index_components_on_website_id"
  end

  create_table "gitconfigs", force: :cascade do |t|
    t.integer "website_id"
    t.string "repo"
    t.string "user"
    t.string "email"
    t.boolean "initialized"
    t.string "link"
    t.datetime "last_commit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["website_id"], name: "index_gitconfigs_on_website_id"
  end

  create_table "images", force: :cascade do |t|
    t.integer "pos"
    t.string "category"
    t.string "name"
    t.string "intro"
    t.string "imageable_type"
    t.integer "imageable_id"
    t.string "upload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"
  end

  create_table "infos", force: :cascade do |t|
    t.integer "website_id"
    t.integer "helper"
    t.integer "pos"
    t.string "title"
    t.text "markdown"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["website_id"], name: "index_infos_on_website_id"
  end

  create_table "maps", force: :cascade do |t|
    t.integer "website_id"
    t.integer "helper"
    t.integer "pos"
    t.string "title"
    t.string "intro"
    t.text "geo"
    t.text "markdown"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["website_id"], name: "index_maps_on_website_id"
  end

  create_table "previews", force: :cascade do |t|
    t.integer "website_id"
    t.string "prototype"
    t.string "name"
    t.integer "status"
    t.integer "process"
    t.string "url"
    t.datetime "last_commit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["website_id"], name: "index_previews_on_website_id"
  end

  create_table "styles", force: :cascade do |t|
    t.string "helper"
    t.string "navbar"
    t.string "primary"
    t.string "secondary"
    t.string "background"
    t.string "icon"
    t.string "text"
    t.string "decoration"
    t.string "stylable_type"
    t.integer "stylable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stylable_type", "stylable_id"], name: "index_styles_on_stylable_type_and_stylable_id"
  end

  create_table "terminal_logs", force: :cascade do |t|
    t.integer "helper"
    t.string "info"
    t.string "level"
    t.text "message"
    t.string "loggable_type"
    t.integer "loggable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loggable_type", "loggable_id"], name: "index_terminal_logs_on_loggable_type_and_loggable_id"
  end

  create_table "themes", force: :cascade do |t|
    t.integer "website_id"
    t.integer "helper"
    t.integer "pos"
    t.string "title"
    t.string "intro"
    t.text "markdown"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["website_id"], name: "index_themes_on_website_id"
  end

  create_table "websites", force: :cascade do |t|
    t.integer "helper"
    t.string "name"
    t.string "description"
    t.text "readme"
    t.string "site_title"
    t.string "home_title"
    t.string "home_icon"
    t.string "top_title"
    t.string "top_intro"
    t.string "bottom_title"
    t.string "bottom_intro"
    t.string "featured_title"
    t.boolean "show_featured"
    t.boolean "show_markdown"
    t.text "markdown"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
