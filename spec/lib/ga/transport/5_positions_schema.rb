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
      @machine_a = Fabricate(:machine)
      @machine_b = Fabricate(:machine)
      @machine_c = Fabricate(:machine)
      @machine_d = Fabricate(:machine)
      @machine_e = Fabricate(:machine)
      @position_a = Fabricate(:position, :schema => @schema, :machine => @machine_a)
      @position_b = Fabricate(:position, :schema => @schema, :machine => @machine_b)
      @position_c = Fabricate(:position, :schema => @schema, :machine => @machine_c)
      @position_d = Fabricate(:position, :schema => @schema, :machine => @machine_d)
      @position_e = Fabricate(:position, :schema => @schema, :machine => @machine_e)
      @path_ab = Fabricate(:segment, :origin => @position_a, :target => @position_b, :distance => 100)
      @path_ac = Fabricate(:segment, :origin => @position_a, :target => @position_c, :distance => 100)
      @path_ad = Fabricate(:segment, :origin => @position_a, :target => @position_d, :distance => 300)
      @path_bc = Fabricate(:segment, :origin => @position_b, :target => @position_c, :distance => 100)
      @path_be = Fabricate(:segment, :origin => @position_b, :target => @position_e, :distance => 300)
      @path_cd = Fabricate(:segment, :origin => @position_c, :target => @position_d, :distance => 200)
      @path_ce = Fabricate(:segment, :origin => @position_c, :target => @position_e, :distance => 200)
      @path_de = Fabricate(:segment, :origin => @position_d, :target => @position_e, :distance => 100)
    end
    
    it 'getting a valid transport roadmap' do
      transport = Transport.new(
        :schema => @schema,
        :roadmap => Fabricate(:roadmap, :machines => [@machine_a, @machine_c, @machine_d])
      )
      
      path_ac = transport.paths[0]
      path_ac.first[:position].should == @position_a
      path_ac.last[:position].should == @position_c
      
      path_cd = transport.paths[1]
      path_cd.first[:position].should == @position_c
      path_cd.last[:position].should == @position_d
    end
    
    context 'follow the roadmap order' do
      before(:each) do
        @transport = Transport.new(
          :schema => @schema,
          :roadmap => Fabricate(:roadmap, :machines => [@machine_a, @machine_b, @machine_c, @machine_d])
        )
      end
      
      it 'first path (A-B)' do
        @transport.paths[0].start.should == @position_a
        @transport.paths[0].goal.should == @position_b
        @transport.paths[0].first[:parent].should == nil
        @transport.paths[0].first[:position].should == @position_a
        @transport.paths[0].last[:parent][:position].should == @position_a
        @transport.paths[0].last[:position].should == @position_b
      end
      
      it 'second path (B-C)' do
        @transport.paths[1].start.should == @position_b
        @transport.paths[1].goal.should == @position_c
        @transport.paths[1].first[:parent].should == nil
        @transport.paths[1].first[:position].should == @position_b
        @transport.paths[1].last[:parent][:position].should == @position_b
        @transport.paths[1].last[:position].should == @position_c
      end
      
      it 'third path (C-D)' do
        @transport.paths[2].start.should == @position_c
        @transport.paths[2].goal.should == @position_d
        @transport.paths[2].first[:parent].should == nil
        @transport.paths[2].first[:position].should == @position_c
        @transport.paths[2].last[:parent][:position].should == @position_c
        @transport.paths[2].last[:position].should == @position_d
      end
    end
    
    it 'should be able to fit to a new roadmap' do
      transport = Transport.new(
        :schema => @schema,
        :roadmap => Fabricate(:roadmap, :machines => [@machine_a, @machine_b, @machine_c, @machine_d])
      )
      paths_before = transport.paths.dup
      
      transport.roadmap = Fabricate(:roadmap, :machines => [@machine_b, @machine_c, @machine_d, @machine_e])
      
      transport.paths[0].should == paths_before[1]
      transport.paths[1].should == paths_before[2]
      transport.paths[2].start.should == @position_d
      transport.paths[2].goal.should == @position_e
      transport.paths[2].first[:position].should == @position_d
      transport.paths[2].last[:position].should == @position_e
    end
    
    context 'distance and time' do
      before(:each) do
        @transport = Transport.new(
          :schema => @schema,
          :roadmap => Fabricate(:roadmap, :machines => [@machine_a, @machine_c, @machine_d]),
          :vehicle => Fabricate(:vehicle, :speed => 3)
        )
      end

      it 'should be able to get the distance from a machine to other' do
        @transport.distance_to(@machine_a, @machine_c).should == 100
        @transport.distance_to(@machine_c, @machine_d).should == 200
      end

      it 'should be able to get the time from a machine to other' do
        @transport.time_to(@machine_a, @machine_c).should == 2 #minutes
        @transport.time_to(@machine_c, @machine_d).should == 4 #minutes
      end

    end
  end
  
end