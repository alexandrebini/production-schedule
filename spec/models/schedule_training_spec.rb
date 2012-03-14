require 'spec_helper'

describe ScheduleTraining do
  it 'have a valid generator' do
    Fabricate(:schedule_training).should be_valid
  end

  it 'have products' do
    Fabricate.build(:schedule_training, :products => []).should_not be_valid
  end
end