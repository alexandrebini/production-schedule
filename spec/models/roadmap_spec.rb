require 'spec_helper'

describe Roadmap do
  it 'have a valid generator' do
    Fabricate(:roadmap).should be_valid
  end

  it 'have product' do
    Fabricate.build(:roadmap, :product => nil).should_not be_valid
  end

  it 'have machines' do
    Fabricate.build(:roadmap, :machines => []).should_not be_valid
  end
  
  context 'getting paths (machine pairs)' do
    before(:each) do
      @machineA = Fabricate(:machine)
      @machineB = Fabricate(:machine)
      @machineC = Fabricate(:machine)
      @machineD = Fabricate(:machine)
      @machineE = Fabricate(:machine)
    end
    
    it 'for 3 machines' do
      roadmap = Fabricate(:roadmap, :machines => [@machineA, @machineB, @machineC])
      roadmap.paths.should == [
        [@machineA, @machineB],
        [@machineB, @machineC]
      ]
    end
    
    it 'for 4 machines' do
      roadmap = Fabricate(:roadmap, :machines => [@machineA, @machineB, @machineC, @machineD])
      roadmap.paths.should == [
        [@machineA, @machineB],
        [@machineB, @machineC],
        [@machineC, @machineD]
      ]
    end
  
    it 'for 5 machines' do
      roadmap = Fabricate(:roadmap, :machines => [@machineA, @machineB, @machineC, @machineD, @machineE])
      roadmap.paths.should == [
        [@machineA, @machineB],
        [@machineB, @machineC],
        [@machineC, @machineD],
        [@machineD, @machineE]
      ]
    end
  end
end