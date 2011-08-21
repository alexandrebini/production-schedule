class CreateOperationTimes < ActiveRecord::Migration
  def change
    create_table :operation_times do |t|
      t.references :product, :machine
      t.integer :time
    end
    add_index :operation_times, :product_id
    add_index :operation_times, :machine_id
    add_index :operation_times, [:product_id, :machine_id]
  end
end

