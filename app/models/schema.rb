class Schema < ActiveRecord::Base
  # associations
  has_many :positions
  has_many :paths, :finder_sql => proc {
    "SELECT paths.* FROM paths
    INNER JOIN positions ON paths.origin_id = positions.id OR paths.target_id = positions.id
    WHERE positions.schema_id = #{id}"
  }
  
  # validations
  validates :name, :presence => true, :uniqueness => true
end