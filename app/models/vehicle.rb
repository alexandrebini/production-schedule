class Vehicle < ActiveRecord::Base
  # validations
  validates_presence_of :name, :speed
  validates_numericality_of :speed, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 10
  
  # scopes
  scope :random, :order => 'RAND()'
  
  # others
  def time_to(distance_in_meters)
    distance_in_meters / speed_in_meters_per_minute
  end
  
  def speed_in_meters_per_minute
    (speed.to_f/60) * 1000
  end
  
end