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
    position_a = Fabricate(:position, :schema => schema)
    position_b = Fabricate(:position, :schema => schema)
    position_c = Fabricate(:position, :schema => schema)
    path_ab = Fabricate(:segment, :origin => position_a, :target => position_b)
    path_ac = Fabricate(:segment, :origin => position_a, :target => position_c)
    path_bc = Fabricate(:segment, :origin => position_b, :target => position_c)
        
    position_a.neighbors.should == [position_b, position_c]
    position_b.neighbors.should == [position_a, position_c]
    position_c.neighbors.should == [position_a, position_b]
  end
end