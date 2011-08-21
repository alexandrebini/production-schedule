class CreateRoadmaps < ActiveRecord::Migration
  def change
    create_table :roadmaps do |t|
      t.references :product

      t.timestamps
    end
    add_index :roadmaps, :product_id
  end
end
