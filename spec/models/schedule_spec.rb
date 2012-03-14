require 'spec_helper'

describe Schedule do
  it 'have a valid generator' do
    Fabricate(:schedule).should be_valid
  end

  it 'have operations' do
    Fabricate.build(:schedule, :operations => []).should_not be_valid
  end

  it 'should be able to get makespan' do
    schedule = Fabricate.build(:schedule, :operations => [])
    schedule.operations << Fabricate.build(:schedule_operation, :schedule => schedule, :start_at => 0, :end_at => 100)
    schedule.makespan.should == 100
    schedule.operations << Fabricate.build(:schedule_operation, :schedule => schedule, :start_at => 50, :end_at => 150)
    schedule.makespan.should == 150
    schedule.operations << Fabricate.build(:schedule_operation, :schedule => schedule, :start_at => 0, :end_at => 151)
    schedule.makespan.should == 151
    schedule.operations << Fabricate.build(:schedule_operation, :schedule => schedule, :start_at => 10, :end_at => 100)
    schedule.makespan.should == 151
  end

end