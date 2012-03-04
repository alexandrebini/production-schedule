require "spec_helper"

describe Path do
  it 'have a valid generator' do
    Fabricate(:path).should be_valid
  end
  
  it 'should have a origin' do
    Fabricate.build(:path, :origin => nil).should_not be_valid
  end
  
  it 'should have a machine' do
    Fabricate.build(:path, :target => nil).should_not be_valid
  end
  
  it 'should have distance' do
    Fabricate.build(:path, :distance => nil).should_not be_valid
  end
  
  it 'distance should be between 1 and 100' do
    Fabricate.build(:path, :distance => 0).should_not be_valid
    Fabricate.build(:path, :distance => 1).should be_valid
    Fabricate.build(:path, :distance => 100).should be_valid
    Fabricate.build(:path, :distance => 101).should_not be_valid
  end
  
  it 'should be able to get path to a position' do
    position = Fabricate(:position)
    path = Fabricate(:path, :origin => position)
    path_to_position = Path.to_position(position.id).first
    path_to_position.should == path
    [path_to_position.origin, path_to_position.target].should include(position)
  end
end