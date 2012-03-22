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
      @machine_a = Fabricate(:machine)
      @machine_b = Fabricate(:machine)
      @machine_c = Fabricate(:machine)
      @machine_d = Fabricate(:machine)
      @machine_e = Fabricate(:machine)
    end
    
    it 'for 3 machines' do
      roadmap = Fabricate(:roadmap, :machines => [@machine_a, @machine_b, @machine_c])
      roadmap.paths.should == [
        [@machine_a, @machine_b],
        [@machine_b, @machine_c]
      ]
    end
    
    it 'for 4 machines' do
      roadmap = Fabricate(:roadmap, :machines => [@machine_a, @machine_b, @machine_c, @machine_d])
      roadmap.paths.should == [
        [@machine_a, @machine_b],
        [@machine_b, @machine_c],
        [@machine_c, @machine_d]
      ]
    end
  
    it 'for 5 machines' do
      roadmap = Fabricate(:roadmap, :machines => [@machine_a, @machine_b, @machine_c, @machine_d, @machine_e])
      roadmap.paths.should == [
        [@machine_a, @machine_b],
        [@machine_b, @machine_c],
        [@machine_c, @machine_d],
        [@machine_d, @machine_e]
      ]
    end
  end
end