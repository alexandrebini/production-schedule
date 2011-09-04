class CreateScheduleTrainingsProducts < ActiveRecord::Migration
  def change
    create_table :schedule_trainings_products, :id => false do |t|
      t.references :schedule_training
      t.references :product
    end
    add_index :schedule_trainings_products, :schedule_training_id
    add_index :schedule_trainings_products, :product_id
    add_index :schedule_trainings_products, [:schedule_training_id, :product_id], :name => "index_schedule_trainings_products_on_schtrainingid_prodid"
  end
end

