require "spec_helper"

describe ScheduleOperation do
  it 'have a valid generator' do
    Fabricate(:schedule_operation).should be_valid
  end

  it 'have schedule' do
    Fabricate.build(:schedule_operation, :schedule => nil).should_not be_valid
  end

  it 'have schedule' do
    Fabricate.build(:schedule_operation, :schedule => nil).should_not be_valid
  end

  it 'have product' do
    Fabricate.build(:schedule_operation, :product => nil).should_not be_valid
  end

  it 'have machine' do
    Fabricate.build(:schedule_operation, :machine => nil).should_not be_valid
  end

  it 'start_at is less than end_at and end_at is greater than start_at' do
    Fabricate.build(:schedule_operation, :start_at => 0, :end_at => 100).should be_valid
    Fabricate.build(:schedule_operation, :start_at => 100, :end_at => 100).should_not be_valid
    Fabricate.build(:schedule_operation, :start_at => 100, :end_at => 0).should_not be_valid
  end
end