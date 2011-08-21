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

ActiveRecord::Schema.define(:version => 20110821151526) do

  create_table "machines", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operation_times", :force => true do |t|
    t.integer "product_id"
    t.integer "machine_id"
    t.integer "time"
  end

  add_index "operation_times", ["machine_id"], :name => "index_operation_times_on_machine_id"
  add_index "operation_times", ["product_id", "machine_id"], :name => "index_operation_times_on_product_id_and_machine_id"
  add_index "operation_times", ["product_id"], :name => "index_operation_times_on_product_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roadmaps", :force => true do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roadmaps", ["product_id"], :name => "index_roadmaps_on_product_id"

  create_table "roadmaps_machines", :id => false, :force => true do |t|
    t.integer "roadmap_id"
    t.integer "machine_id"
  end

  add_index "roadmaps_machines", ["machine_id"], :name => "index_roadmaps_machines_on_machine_id"
  add_index "roadmaps_machines", ["roadmap_id", "machine_id"], :name => "index_roadmaps_machines_on_roadmap_id_and_machine_id"
  add_index "roadmaps_machines", ["roadmap_id"], :name => "index_roadmaps_machines_on_roadmap_id"

end
