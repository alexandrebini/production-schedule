class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.integer :origin_id
      t.integer :target_id
      t.integer :distance
    end
    add_index :segments, :origin_id
    add_index :segments, :target_id
  end
end