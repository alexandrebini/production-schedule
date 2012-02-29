class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name
      t.references :schema
      t.references :machine
    end
    add_index :positions, :schema_id
    add_index :positions, :machine_id
  end
end