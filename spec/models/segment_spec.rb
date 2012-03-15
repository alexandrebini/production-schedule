require 'spec_helper'

describe Segment do
  it 'have a valid generator' do
    Fabricate(:segment).should be_valid
  end
  
  it 'should have a origin' do
    Fabricate.build(:segment, :origin => nil).should_not be_valid
  end
  
  it 'should have a machine' do
    Fabricate.build(:segment, :target => nil).should_not be_valid
  end
  
  it 'should have distance' do
    Fabricate.build(:segment, :distance => nil).should_not be_valid
  end
  
  it 'should be able to get path to a position' do
    position = Fabricate(:position)
    segment = Fabricate(:segment, :origin => position)
    segment_to_position = Segment.to_position(position.id).first
    segment_to_position.should == segment
    [segment_to_position.origin, segment_to_position.target].should include(position)
  end
end