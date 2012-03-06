class Product < ActiveRecord::Base
  has_many :roadmaps, :inverse_of => :product
  has_many :operation_times, :inverse_of => :product do
    def of_machine(machine_id)
      self.find_by_machine_id(machine_id)
    end
  end
  has_many :machines, :through => :operation_times
  has_and_belongs_to_many :schedule_trainings, :join_table => 'schedule_trainings_products'

  validates_presence_of :name

  # scopes
  scope :random, :order => 'RAND()'
end