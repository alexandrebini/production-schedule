require "spec_helper"

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
  
  context 'getting machine pairs' do
    before(:each) do
      @schema = Fabricate(:schema)
      @machineA = Fabricate(:machine)
      @machineB = Fabricate(:machine)
      @machineC = Fabricate(:machine)
      @machineD = Fabricate(:machine)
      @machineE = Fabricate(:machine)
    end
    
    it 'for 3 machines' do
      transport = Transport.new(
        :schema => @schema,
        :roadmap => Fabricate(:roadmap, :machines => [@machineA, @machineB, @machineC])
      )
      transport.machine_pairs.should == [
        [@machineA, @machineB],
        [@machineB, @machineC]
      ]
    end
    
    it 'for 4 machines' do
      transport = Transport.new(
        :schema => @schema,
        :roadmap => Fabricate(:roadmap, :machines => [@machineA, @machineB, @machineC, @machineD])
      )
      transport.machine_pairs.should == [
        [@machineA, @machineB],
        [@machineB, @machineC],
        [@machineC, @machineD]
      ]
    end
  
    it 'for 5 machines' do
      transport = Transport.new(
        :schema => @schema,
        :roadmap => Fabricate(:roadmap, :machines => [@machineA, @machineB, @machineC, @machineD, @machineE])
      )
      transport.machine_pairs.should == [
        [@machineA, @machineB],
        [@machineB, @machineC],
        [@machineC, @machineD],
        [@machineD, @machineE]
      ]
    end
  end
  
  context '5 positions schema' do
    before(:each) do
      # A -- B
      # |\ / |
      # | C  |
      # |/  \|
      # D -- E
      @schema = Fabricate(:schema)
      @machineA = Fabricate(:machine)
      @machineB = Fabricate(:machine)
      @machineC = Fabricate(:machine)
      @machineD = Fabricate(:machine)
      @machineE = Fabricate(:machine)
      @positionA = Fabricate(:position, :schema => @schema, :machine => @machineA)
      @positionB = Fabricate(:position, :schema => @schema, :machine => @machineB)
      @positionC = Fabricate(:position, :schema => @schema, :machine => @machineC)
      @positionD = Fabricate(:position, :schema => @schema, :machine => @machineD)
      @positionE = Fabricate(:position, :schema => @schema, :machine => @machineE)
      @pathAB = Fabricate(:path, :origin => @positionA, :target => @positionB)
      @pathAC = Fabricate(:path, :origin => @positionA, :target => @positionC)
      @pathAD = Fabricate(:path, :origin => @positionA, :target => @positionD)
      @pathBC = Fabricate(:path, :origin => @positionB, :target => @positionC)
      @pathBE = Fabricate(:path, :origin => @positionB, :target => @positionE)
      @pathCD = Fabricate(:path, :origin => @positionC, :target => @positionD)
      @pathCE = Fabricate(:path, :origin => @positionC, :target => @positionE)
      @pathDE = Fabricate(:path, :origin => @positionD, :target => @positionE)
    end
    
    it 'getting a valid transport roadmap' do
      transport = Transport.new(
        :schema => @schema,
        :roadmap => Fabricate(:roadmap, :machines => [@machineA, @machineC, @machineD])
      )
      transport.find_path
      
      pathAC = transport.paths[0]
      pathAC.path.first[:position].should == @positionA
      pathAC.path.last[:position].should == @positionC
      
      pathCD = transport.paths[1]
      pathCD.path.first[:position].should == @positionC
      pathCD.path.last[:position].should == @positionD
    end
  end
  
end