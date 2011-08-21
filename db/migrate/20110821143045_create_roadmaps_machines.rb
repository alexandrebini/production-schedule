class CreateRoadmapsMachines < ActiveRecord::Migration
  def change
    create_table :roadmaps_machines, :id => false do |t|
      t.references :roadmap, :machine
    end
    add_index :roadmaps_machines, :roadmap_id
    add_index :roadmaps_machines, :machine_id
    add_index :roadmaps_machines, [:roadmap_id, :machine_id]
  end
end

