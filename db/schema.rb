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

ActiveRecord::Schema.define(:version => 20120301124348) do

  create_table "machines", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "operation_times", :force => true do |t|
    t.integer "product_id"
    t.integer "machine_id"
    t.integer "time"
  end

  add_index "operation_times", ["machine_id"], :name => "index_operation_times_on_machine_id"
  add_index "operation_times", ["product_id", "machine_id"], :name => "index_operation_times_on_product_id_and_machine_id"
  add_index "operation_times", ["product_id"], :name => "index_operation_times_on_product_id"

  create_table "positions", :force => true do |t|
    t.string  "name"
    t.integer "schema_id"
    t.integer "machine_id"
  end

  add_index "positions", ["machine_id"], :name => "index_positions_on_machine_id"
  add_index "positions", ["schema_id"], :name => "index_positions_on_schema_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "roadmaps", :force => true do |t|
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roadmaps", ["product_id"], :name => "index_roadmaps_on_product_id"

  create_table "roadmaps_machines", :id => false, :force => true do |t|
    t.integer "roadmap_id"
    t.integer "machine_id"
  end

  add_index "roadmaps_machines", ["machine_id"], :name => "index_roadmaps_machines_on_machine_id"
  add_index "roadmaps_machines", ["roadmap_id", "machine_id"], :name => "index_roadmaps_machines_on_roadmap_id_and_machine_id"
  add_index "roadmaps_machines", ["roadmap_id"], :name => "index_roadmaps_machines_on_roadmap_id"

  create_table "schedule_operations", :force => true do |t|
    t.integer "schedule_id"
    t.integer "product_id"
    t.integer "machine_id"
    t.integer "start_at"
    t.integer "end_at"
  end

  add_index "schedule_operations", ["machine_id"], :name => "index_schedule_operations_on_machine_id"
  add_index "schedule_operations", ["product_id", "machine_id"], :name => "index_schedule_operations_on_product_id_and_machine_id"
  add_index "schedule_operations", ["product_id"], :name => "index_schedule_operations_on_product_id"
  add_index "schedule_operations", ["schedule_id"], :name => "index_schedule_operations_on_schedule_id"

  create_table "schedule_trainings", :force => true do |t|
    t.integer "length"
    t.integer "max_generations"
    t.integer "mutation_rate"
    t.integer "crossover_rate"
  end

  create_table "schedule_trainings_products", :id => false, :force => true do |t|
    t.integer "schedule_training_id"
    t.integer "product_id"
  end

  add_index "schedule_trainings_products", ["product_id"], :name => "index_schedule_trainings_products_on_product_id"
  add_index "schedule_trainings_products", ["schedule_training_id", "product_id"], :name => "index_schedule_trainings_products_on_schtrainingid_prodid"
  add_index "schedule_trainings_products", ["schedule_training_id"], :name => "index_schedule_trainings_products_on_schedule_training_id"

  create_table "schedules", :force => true do |t|
    t.integer "schedule_training_id"
    t.decimal "makespan",             :precision => 10, :scale => 2
  end

  add_index "schedules", ["schedule_training_id"], :name => "index_schedules_on_schedule_training_id"

  create_table "schemas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "segments", :force => true do |t|
    t.integer "origin_id"
    t.integer "target_id"
    t.integer "distance"
  end

  add_index "segments", ["origin_id"], :name => "index_segments_on_origin_id"
  add_index "segments", ["target_id"], :name => "index_segments_on_target_id"

  create_table "vehicles", :force => true do |t|
    t.string  "name"
    t.integer "speed"
  end

  add_index "vehicles", ["speed"], :name => "index_vehicles_on_speed"

end
