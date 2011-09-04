class ScheduleOperation < ActiveRecord::Base
  # associations
  belongs_to :schedule
  belongs_to :product
  belongs_to :machine

  # validations
  validates_presence_of :schedule, :product, :machine, :start_at, :end_at
  validates_numericality_of :start_at, :less_than => :end_at
  validates_numericality_of :end_at, :greater_than => :start_at


end

