class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :name
      t.integer :speed
    end
    add_index :vehicles, :speed
  end
end