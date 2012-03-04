class Position < ActiveRecord::Base
  # associations
  belongs_to :schema
  belongs_to :machine

  # validations
  validates_presence_of :schema_id, :machine_id
  validates_uniqueness_of :machine_id, :scope => :schema_id
  
  def paths
    @paths = Path.where("paths.origin_id = #{id} OR paths.target_id = #{id}")
  end
  
  def neighbors
    @neighbors ||= paths.map do |path|
      [path.origin, path.target]
    end.flatten.compact.uniq.delete_if{ |r| r == self}
  end
  
  def path_to(neighbor)
    paths.to_position(neighbor.id).first
  end
end