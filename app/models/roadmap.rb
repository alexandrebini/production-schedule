class Roadmap < ActiveRecord::Base
  # associations
  has_and_belongs_to_many :machines, :join_table => 'roadmaps_machines'
  belongs_to :product
  attr_reader :paths

  # validations
  validates_presence_of :product, :machines
  # validates_inclusion_of :machines, :in => proc{ |roadmap| p roadmap.product.machines, roadmap.machines; roadmap.product.machines }

  # scopes
  scope :random, :order => 'RAND()'
  
  # others
  def paths
    return @paths unless @paths.nil?
    @paths = []
    machines.each_with_index do |machine, index|
      break if index == machines.size - 1
      @paths << [machine, machines[index+1]]
    end
    @paths
  end
end

