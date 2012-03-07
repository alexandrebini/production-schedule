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
    Fabricate.build(:vehicle, :speed => 0).should_not be_valid
    Fabricate.build(:vehicle, :speed => 1).should be_valid
    Fabricate.build(:vehicle, :speed => 10).should be_valid
    Fabricate.build(:vehicle, :speed => 11).should_not be_valid
  end
  
  it 'should be able to convert kilometer/hour to meter/minute' do
    Fabricate.build(:vehicle, :speed => 3).speed_in_meters_per_minute.should == 50
    Fabricate.build(:vehicle, :speed => 6).speed_in_meters_per_minute.should == 100
    Fabricate.build(:vehicle, :speed => 15).speed_in_meters_per_minute.should == 250
    Fabricate.build(:vehicle, :speed => 30).speed_in_meters_per_minute.should == 500
    Fabricate.build(:vehicle, :speed => 60).speed_in_meters_per_minute.should == 1_000
    Fabricate.build(:vehicle, :speed => 120).speed_in_meters_per_minute.should == 2_000
  end
    
  it 'should be able to get the time to traverse a distance' do
    # 100km/hour to travel 100_000 meters (1km)
    Fabricate.build(:vehicle, :speed => 100).time_to(100_000).should == 60
    # 60km/hour to travel 100 meters
    Fabricate.build(:vehicle, :speed => 50).time_to(100_000).should == 120
    # 100km/hour to travel 100 meters
    Fabricate.build(:vehicle, :speed => 60).time_to(100).should == 0.1
    # 3km/hour to travel 100 meters (1km)
    Fabricate.build(:vehicle, :speed => 3).time_to(100).should == 2
  end
end