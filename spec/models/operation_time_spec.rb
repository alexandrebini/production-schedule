require "spec_helper"

describe OperationTime do
  it 'have a valid generator' do
    OperationTime.make!.should be_valid
  end

  it 'have a machine' do
    OperationTime.make(:machine => nil).should_not be_valid
  end

  it 'have a product' do
    OperationTime.make(:product => nil).should_not be_valid
  end

  it 'have time' do
    OperationTime.make(:time => nil).should_not be_valid
  end

  it 'time greater than zero' do
    OperationTime.make(:time => 0).should_not be_valid
    OperationTime.make(:time => -10).should_not be_valid
  end
end

