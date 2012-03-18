require 'spec_helper'

describe Transport do
  
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
      @pathAB = Fabricate(:segment, :origin => @positionA, :target => @positionB, :distance => 100)
      @pathAC = Fabricate(:segment, :origin => @positionA, :target => @positionC, :distance => 100)
      @pathAD = Fabricate(:segment, :origin => @positionA, :target => @positionD, :distance => 300)
      @pathBC = Fabricate(:segment, :origin => @positionB, :target => @positionC, :distance => 100)
      @pathBE = Fabricate(:segment, :origin => @positionB, :target => @positionE, :distance => 300)
      @pathCD = Fabricate(:segment, :origin => @positionC, :target => @positionD, :distance => 200)
      @pathCE = Fabricate(:segment, :origin => @positionC, :target => @positionE, :distance => 200)
      @pathDE = Fabricate(:segment, :origin => @positionD, :target => @positionE, :distance => 100)
    end
    
    it 'getting a valid transport roadmap' do
      transport = Transport.new(
        :schema => @schema,
        :roadmap => Fabricate(:roadmap, :machines => [@machineA, @machineC, @machineD])
      )
      
      pathAC = transport.paths[0]
      pathAC.first[:position].should == @positionA
      pathAC.last[:position].should == @positionC
      
      pathCD = transport.paths[1]
      pathCD.first[:position].should == @positionC
      pathCD.last[:position].should == @positionD
    end
    
    context 'follow the roadmap order' do
      before(:each) do
        @transport = Transport.new(
          :schema => @schema,
          :roadmap => Fabricate(:roadmap, :machines => [@machineA, @machineB, @machineC, @machineD])
        )
      end
      
      it 'first path (A-B)' do
        @transport.paths[0].start.should == @positionA
        @transport.paths[0].goal.should == @positionB
        @transport.paths[0].first[:parent].should == nil
        @transport.paths[0].first[:position].should == @positionA
        @transport.paths[0].last[:parent][:position].should == @positionA
        @transport.paths[0].last[:position].should == @positionB
      end
      
      it 'second path (B-C)' do
        @transport.paths[1].start.should == @positionB
        @transport.paths[1].goal.should == @positionC
        @transport.paths[1].first[:parent].should == nil
        @transport.paths[1].first[:position].should == @positionB
        @transport.paths[1].last[:parent][:position].should == @positionB
        @transport.paths[1].last[:position].should == @positionC
      end
      
      it 'third path (C-D)' do
        @transport.paths[2].start.should == @positionC
        @transport.paths[2].goal.should == @positionD
        @transport.paths[2].first[:parent].should == nil
        @transport.paths[2].first[:position].should == @positionC
        @transport.paths[2].last[:parent][:position].should == @positionC
        @transport.paths[2].last[:position].should == @positionD
      end
    end
    
    it 'should be able to fit to a new roadmap' do
      transport = Transport.new(
        :schema => @schema,
        :roadmap => Fabricate(:roadmap, :machines => [@machineA, @machineB, @machineC, @machineD])
      )
      paths_before = transport.paths.dup
      
      transport.roadmap = Fabricate(:roadmap, :machines => [@machineB, @machineC, @machineD, @machineE])
      
      transport.paths[0].should == paths_before[1]
      transport.paths[1].should == paths_before[2]
      transport.paths[2].start.should == @positionD
      transport.paths[2].goal.should == @positionE
      transport.paths[2].first[:position].should == @positionD
      transport.paths[2].last[:position].should == @positionE
    end
    
    context 'distance and time' do
      before(:each) do
        @transport = Transport.new(
          :schema => @schema,
          :roadmap => Fabricate(:roadmap, :machines => [@machineA, @machineC, @machineD]),
          :vehicle => Fabricate(:vehicle, :speed => 3)
        )
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