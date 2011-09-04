class CreateScheduleOperations < ActiveRecord::Migration
  def change
    create_table :schedule_operations do |t|
      t.references :schedule, :product, :machine
      t.integer :start_at
      t.integer :end_at
    end
    add_index :schedule_operations, :schedule_id
    add_index :schedule_operations, [:product_id, :machine_id]
    add_index :schedule_operations, :product_id
    add_index :schedule_operations, :machine_id
  end
end

