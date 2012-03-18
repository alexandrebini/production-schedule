require 'spec_helper'

describe Transport do
  
  it 'have a valid generator' do
    lambda{ Fabricate(:transport) }.should_not raise_error
  end
  
  it 'should have roadmap' do
    lambda{ Transport.new(:roadmap => nil, :schema => Fabricate(:schema)) }.should raise_error
  end
  
  it 'should have schema' do
    lambda{ Transport.new(:roadmap => Fabricate(:roadmap), :schema => nil) }.should raise_error
  end
  
  it 'should get a random vehicle when none is given' do
    10.times{ Fabricate(:vehicle) }
    transport = Transport.new(:roadmap => Fabricate(:roadmap), :schema => Fabricate(:schema), :vehicle => nil)
    lambda{ transport.vehicle }.should_not raise_error
    transport.vehicle.class.should == Vehicle
  end
  
  it 'should be able to be compared to other transport' do
    pending
  end
  
end