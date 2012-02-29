class Path < ActiveRecord::Base
  # associations
  belongs_to :origin, :class_name => 'Position'
  belongs_to :target, :class_name => 'Position'
  
  # validations
  validates_presence_of :origin, :target
  validates_uniqueness_of :origin, :scope => :target
  validates_uniqueness_of :target, :scope => :origin
end