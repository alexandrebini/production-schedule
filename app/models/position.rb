class Position < ActiveRecord::Base
  # associations
  belongs_to :schema
  belongs_to :machine
  
  # validations
  validates_presence_of :schema_id, :machine_id
  validates_uniqueness_of :machine_id, :scope => :schema_id
end