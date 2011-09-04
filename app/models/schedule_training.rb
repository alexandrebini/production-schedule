class ScheduleTraining < ActiveRecord::Base
  has_and_belongs_to_many :products, :join_table => 'schedule_trainings_products'
  has_many :schedules

  validates_presence_of :products
end

