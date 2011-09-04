require "spec_helper"

describe ScheduleTraining do
  it 'have a valid generator' do
    ScheduleTraining.make!.should be_valid
  end

  it 'have products' do
    ScheduleTraining.make(:products => []).should_not be_valid
  end

end

