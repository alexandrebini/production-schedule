require "spec_helper"

describe Vehicle do
  it 'have a valid generator' do
    Fabricate(:vehicle).should be_valid
  end
  
  it 'should have a name' do
    Fabricate.build(:vehicle, :name => nil).should_not be_valid
  end
  
  it 'should have speed' do
    Fabricate.build(:vehicle, :speed => nil).should_not be_valid
  end
  
  it 'speed should be between 1 and 10' do
    Fabricate.build(:vehicle, :distance => 0).should_not be_valid
    Fabricate.build(:vehicle, :distance => 1).should be_valid
    Fabricate.build(:vehicle, :distance => 10).should be_valid
    Fabricate.build(:vehicle, :distance => 11).should_not be_valid
  end
end