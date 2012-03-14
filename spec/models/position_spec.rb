require 'spec_helper'

describe Position do
  it 'have a valid generator' do
    Fabricate(:position).should be_valid
  end
  
  it 'should have a schema' do
    Fabricate.build(:position, :schema => nil).should_not be_valid
  end
  
  it 'should have a machine' do
    Fabricate.build(:position, :machine => nil).should_not be_valid
  end
  
  it 'should be able to get neighbors' do
    schema = Fabricate(:schema)
    positionA = Fabricate(:position, :schema => schema)
    positionB = Fabricate(:position, :schema => schema)
    positionC = Fabricate(:position, :schema => schema)
    pathAB = Fabricate(:path, :origin => positionA, :target => positionB)
    pathAC = Fabricate(:path, :origin => positionA, :target => positionC)
    pathBC = Fabricate(:path, :origin => positionB, :target => positionC)
        
    positionA.neighbors.should == [positionB, positionC]
    positionB.neighbors.should == [positionA, positionC]
    positionC.neighbors.should == [positionA, positionB]
  end
end