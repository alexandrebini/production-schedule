class CreateSchemas < ActiveRecord::Migration
  def change
    create_table :schemas do |t|
      t.string :name
      t.timestamps
    end
  end
end