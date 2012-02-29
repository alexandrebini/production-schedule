class Schema < ActiveRecord::Base
  # associations
  has_many :positions
  
  # validations
  validates :name, :presence => true, :uniqueness => true
end