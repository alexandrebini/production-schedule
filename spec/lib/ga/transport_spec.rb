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
  
  context '5 positions schema' do
    before(:each) do
      # A ----- B
      # | \   / |
      # |   C   |
      # |  / \  |
      # |/    \ |
      # D ---- E
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
      @pathAB = Fabricate(:path, :origin => @positionA, :target => @positionB, :distance => 100)
      @pathAC = Fabricate(:path, :origin => @positionA, :target => @positionC, :distance => 100)
      @pathAD = Fabricate(:path, :origin => @positionA, :target => @positionD, :distance => 300)
      @pathBC = Fabricate(:path, :origin => @positionB, :target => @positionC, :distance => 100)
      @pathBE = Fabricate(:path, :origin => @positionB, :target => @positionE, :distance => 300)
      @pathCD = Fabricate(:path, :origin => @positionC, :target => @positionD, :distance => 200)
      @pathCE = Fabricate(:path, :origin => @positionC, :target => @positionE, :distance => 200)
      @pathDE = Fabricate(:path, :origin => @positionD, :target => @positionE, :distance => 100)
    end
    
    it 'getting a valid transport roadmap' do
      transport = Transport.new(
        :schema => @schema,
        :roadmap => Fabricate(:roadmap, :machines => [@machineA, @machineC, @machineD])
      )
      
      transport.find_paths!
      
      pathAC = transport[0]
      pathAC.path.first[:position].should == @positionA
      pathAC.path.last[:position].should == @positionC
      
      pathCD = transport[1]
      pathCD.path.first[:position].should == @positionC
      pathCD.path.last[:position].should == @positionD
    end
    
    it 'should be able to fit to a new roadmap' do
      
    end
    
    context 'distance and time' do
      before(:each) do
        @transport = Transport.new(
          :schema => @schema,
          :roadmap => Fabricate(:roadmap, :machines => [@machineA, @machineC, @machineD]),
          :vehicle => Fabricate(:vehicle, :speed => 3)
        )
        @transport.find_paths!
      end

      it 'should be able to get the distance from a machine to other' do
        @transport.distance_to(@machineA, @machineC).should == 100
        @transport.distance_to(@machineC, @machineD).should == 200
      end

      it 'should be able to get the time from a machine to other' do
        @transport.time_to(@machineA, @machineC).should == 2 #minutes
        @transport.time_to(@machineC, @machineD).should == 4 #minutes
      end

    end
  end
  
end