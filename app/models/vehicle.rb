class Vehicle < ActiveRecord::Base
  # validations
  validates_presence_of :name, :speed
  validates_numericality_of :speed, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 10
  
  # scopes
  scope :random, :order => 'RAND()'
end