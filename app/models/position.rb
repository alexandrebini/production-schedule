class Position < ActiveRecord::Base
  # associations
  belongs_to :schema
  belongs_to :machine
  has_many :paths, :finder_sql => proc{
    "SELECT paths.* FROM paths WHERE paths.origin_id = #{id} OR paths.target_id = #{id}"
  }

  # validations
  validates_presence_of :schema_id, :machine_id
  validates_uniqueness_of :machine_id, :scope => :schema_id
end