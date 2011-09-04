require "spec_helper"

describe ScheduleOperation do
  it 'have a valid generator' do
    ScheduleOperation.make!.should be_valid
  end

  it 'have schedule' do
    ScheduleOperation.make(:schedule => nil).should_not be_valid
  end

  it 'have schedule' do
    ScheduleOperation.make(:schedule => nil).should_not be_valid
  end

  it 'have product' do
    ScheduleOperation.make(:product => nil).should_not be_valid
  end

  it 'have machine' do
    ScheduleOperation.make(:machine => nil).should_not be_valid
  end

  it 'start_at is less than end_at and end_at is greater than start_at' do
    ScheduleOperation.make(:start_at => 0, :end_at => 100).should be_valid
    ScheduleOperation.make(:start_at => 100, :end_at => 100).should_not be_valid
    ScheduleOperation.make(:start_at => 100, :end_at => 0).should_not be_valid
  end
end

