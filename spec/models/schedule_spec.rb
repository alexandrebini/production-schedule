require "spec_helper"

describe Schedule do
  it 'have a valid generator' do
    Schedule.make!.should be_valid
  end

  it 'have makespan' do
    Schedule.make(:makespan => nil).should_not be_valid
  end

end

