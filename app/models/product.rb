class Product < ActiveRecord::Base
  has_many :roadmaps
  has_many :operation_times
  has_many :machines, :through => :operation_times

  validates_presence_of :name

  # scopes
  scope :random, :order => 'RAND()'

  # others
  def to_gene
    Gene.new(:product => self, :roadmap => roadmaps.shuffle.first)
  end
end

