require "spec_helper"

describe Schedule do
  it 'have a valid generator' do
    Schedule.make!.should be_valid
  end

  it 'have operations' do
    Schedule.make(:operations => []).should_not be_valid
  end

  it 'should be able to get makespan' do
    schedule = Schedule.make(:operations => [])
    schedule.operations << ScheduleOperation.make(:schedule => schedule, :start_at => 0, :end_at => 100)
    schedule.makespan.should == 100
    schedule.operations << ScheduleOperation.make(:schedule => schedule, :start_at => 50, :end_at => 150)
    schedule.makespan.should == 150
    schedule.operations << ScheduleOperation.make(:schedule => schedule, :start_at => 0, :end_at => 151)
    schedule.makespan.should == 151
    schedule.operations << ScheduleOperation.make(:schedule => schedule, :start_at => 10, :end_at => 100)
    schedule.makespan.should == 151
  end

end

