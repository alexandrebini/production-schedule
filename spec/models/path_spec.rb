require "spec_helper"

describe Path do
  it 'have a valid generator' do
    Fabricate(:path).should be_valid
  end
  
  it 'should have a origin' do
    Fabricate(:path, :origin => nil).should_not be_valid
  end
  
  it 'should have a machine' do
    Fabricate(:path, :target => nil).should_not be_valid
  end
  
  it 'should have distance' do
    Fabricate(:path, :distance => nil).should_not be_valid
  end
  
  it 'distance should be between 1 and 100' do
    Fabricate(:path, :distance => 0).should_not be_valid
    Fabricate(:path, :distance => 1).should be_valid
    Fabricate(:path, :distance => 100).should be_valid
    Fabricate(:path, :distance => 101).should_not be_valid
  end
end