class Machine < ActiveRecord::Base
  # associations
  has_and_belongs_to_many :rodamaps, :join_table => 'roadmaps_machines'
  has_many :operation_times
  has_many :products, :through => :operation_times

  # validations
  validates_presence_of :name

  # scopes
  scope :random, :order => 'RAND()'
end

