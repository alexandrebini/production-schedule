class Position < ActiveRecord::Base
  # associations
  belongs_to :schema
  belongs_to :machine

  # validations
  validates_presence_of :schema_id, :machine_id
  validates_uniqueness_of :machine_id, :scope => :schema_id
  
  def segments
    @segments ||= Segment.where("segments.origin_id = #{id} OR segments.target_id = #{id}")
  end
  
  def neighbors
    @neighbors ||= segments.map do |segment|
      [segment.origin, segment.target]
    end.flatten.compact.uniq.delete_if{ |r| r == self}
  end
  
  def segment_to(neighbor)
    segments.to_position(neighbor.id).first
  end
end