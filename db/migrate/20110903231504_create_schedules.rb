class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :schedule_training
      t.decimal :makespan, :precision => 10, :scale => 2
    end
    add_index :schedules, :schedule_training_id
  end
end

