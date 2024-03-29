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

ActiveRecord::Schema.define(:version => 20131007141427) do

  create_table "alerts", :force => true do |t|
    t.string   "entidad"
    t.string   "descripcion"
    t.integer  "precio_min"
    t.integer  "precio_max"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "compras", :force => true do |t|
    t.string   "entidad"
    t.decimal  "precio",            :precision => 16, :scale => 2
    t.string   "proponente"
    t.integer  "categoria"
    t.string   "url"
    t.datetime "fecha"
    t.text     "description"
    t.string   "acto"
    t.integer  "compra_id"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.integer  "category_id"
    t.boolean  "done"
    t.tsvector "tsv_description"
    t.string   "compra_type"
    t.string   "dependencia"
    t.string   "nombre_contacto"
    t.string   "telefono_contacto"
    t.string   "correo_contacto"
    t.string   "objeto"
    t.string   "modalidad"
    t.string   "unidad"
    t.string   "provincia"
    t.decimal  "precio_cd",         :precision => 16, :scale => 2
    t.boolean  "parsed"
    t.boolean  "visited"
    t.text     "html"
  end

  add_index "compras", ["tsv_description"], :name => "compras_description"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "queries", :force => true do |t|
    t.string   "query"
    t.string   "entidad"
    t.integer  "price_min"
    t.integer  "price_max"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "ip"
    t.integer  "category_id"
    t.integer  "user_id"
    t.boolean  "empty",       :default => false
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
