require 'spec_helper'

describe OperationTime do
  it 'have a valid generator' do
    Fabricate(:operation_time).should be_valid
  end

  it 'have a machine' do
    Fabricate.build(:operation_time, :machine => nil).should_not be_valid
  end

  it 'have a product' do
    Fabricate.build(:operation_time, :product => nil).should_not be_valid
  end

  it 'have time' do
    Fabricate.build(:operation_time, :time => nil).should_not be_valid
  end

  it 'time greater than zero' do
    Fabricate.build(:operation_time, :time => 0).should_not be_valid
    Fabricate.build(:operation_time, :time => -10).should_not be_valid
  end
end