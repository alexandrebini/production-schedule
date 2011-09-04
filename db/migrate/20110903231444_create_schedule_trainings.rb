class CreateScheduleTrainings < ActiveRecord::Migration
  def change
    create_table :schedule_trainings do |t|
      t.integer :length
      t.integer :max_generations
      t.integer :mutation_rate
      t.integer :crossover_rate
    end
  end
end

