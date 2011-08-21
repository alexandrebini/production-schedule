class OperationTime < ActiveRecord::Base
  belongs_to :machine
  belongs_to :product
  validates_presence_of :machine, :product
  validates_numericality_of :time, :greater_than => 0
end

