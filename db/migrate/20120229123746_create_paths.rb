class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.integer :origin_id
      t.integer :target_id
      t.integer :distance
    end
    add_index :paths, :origin_id
    add_index :paths, :target_id
  end
end