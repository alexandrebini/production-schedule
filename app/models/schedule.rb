class Schedule < ActiveRecord::Base
  # associations
  belongs_to :training, :class_name => 'ScheduleTraining'
  has_many :operations, :class_name => 'ScheduleOperation'

  # validations
  validates_presence_of :operations

  # callbacks
  before_create :set_makespan

  def set_makespan
    self.makespan = makespan
  end

  # others
  def operations_of_machine(machine_id)
    operations.find_all{ |r| r.machine_id == machine_id }
  end

  def operations_of_product(product_id)
    operations.find_all{ |r| r.product_id == product_id }
  end

  def first_operation
    operations.sort_by{ |r| r.start_at }.first
  end

  def last_operation
    operations.sort_by{ |r| r.end_at }.last
  end

  def makespan
    return super unless new_record?
    last_operation.end_at - first_operation.start_at
  end

end

