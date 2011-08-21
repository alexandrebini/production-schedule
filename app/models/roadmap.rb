class Roadmap < ActiveRecord::Base
  has_and_belongs_to_many :machines, :join_table => 'roadmaps_machines'
  belongs_to :product

  validates_presence_of :product, :machines
end

