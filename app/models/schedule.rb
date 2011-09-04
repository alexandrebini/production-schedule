class Schedule < ActiveRecord::Base
  # associations
  belongs_to :training, :class_name => 'ScheduleTraining'
  has_many :operations, :class_name => 'ScheduleOperation'

  # validations
  validates_presence_of :makespan

  # others
  def operations_of_machine(machine_id)
    operations.find_all{ |r| r.machine_id == machine_id }
  end
  def operations_of_product(product_id)
    operations.find_all{ |r| r.product_id == product_id }
  end
end

