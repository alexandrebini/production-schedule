class Path < ActiveRecord::Base
  # associations
  belongs_to :origin, :class_name => 'Position'
  belongs_to :target, :class_name => 'Position'
  
  scope :to_position, lambda{ |position_id|
    where("paths.origin_id = #{position_id} OR paths.target_id = #{position_id}")
  }
  
  # validations
  validates_presence_of :origin, :target, :distance
  validates_numericality_of :distance, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 100
  validates_uniqueness_of :origin_id, :scope => :target_id
  validates_uniqueness_of :target_id, :scope => :origin_id
  
  # others
  def positions
    [origin, target]
  end
end