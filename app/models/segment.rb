class Segment < ActiveRecord::Base
  # associations
  belongs_to :origin, :class_name => 'Position'
  belongs_to :target, :class_name => 'Position'
  
  scope :to_position, lambda{ |position_id|
    where("segments.origin_id = #{position_id} OR segments.target_id = #{position_id}")
  }
  
  # validations
  validates_presence_of :origin, :target, :distance
  validates_uniqueness_of :origin_id, :scope => :target_id
  validates_uniqueness_of :target_id, :scope => :origin_id
  
  # others
  def positions
    [origin, target]
  end
end