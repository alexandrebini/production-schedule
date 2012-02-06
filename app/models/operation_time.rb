class OperationTime < ActiveRecord::Base
  # scopes
  belongs_to :machine
  belongs_to :product

  # validations
  validates_presence_of :machine, :product
  validates_numericality_of :time, :greater_than => 0
  validates_uniqueness_of :machine_id, :scope => :product_id
end