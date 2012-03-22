require 'spec_helper'

describe PathFinder do
  
  it 'acts as array' do
    PathFinder.ancestors.should include(Array)
  end
  
  context '4 positions schema' do
    before(:each) do
      # A -- B
      # |    |
      # C -- D
      schema = Fabricate(:schema)
      @position_a = Fabricate(:position, :schema => schema)
      @position_b = Fabricate(:position, :schema => schema)
      @position_c = Fabricate(:position, :schema => schema)
      @position_d = Fabricate(:position, :schema => schema)
      @path_ab = Fabricate(:segment, :origin => @position_a, :target => @position_b)
      @path_ac = Fabricate(:segment, :origin => @position_a, :target => @position_c)
      @path_cd = Fabricate(:segment, :origin => @position_d, :target => @position_b)
      @pathDB = Fabricate(:segment, :origin => @position_b, :target => @position_d)
    end
    
    it 'should be able to get a valid route between 2 points' do
      result = PathFinder.find(@position_a, @position_d)
      result.first[:position].should == @position_a
      result.last[:position].should == @position_d
    end
  end
  
  context '5 positions schema' do
    before(:each) do
      # A -- B
      # |\ / |
      # | C  |
      # |/  \|
      # D -- E
      schema = Fabricate(:schema)
      @position_a = Fabricate(:position, :schema => schema)
      @position_b = Fabricate(:position, :schema => schema)
      @position_c = Fabricate(:position, :schema => schema)
      @position_d = Fabricate(:position, :schema => schema)
      @position_e = Fabricate(:position, :schema => schema)
      @path_ab = Fabricate(:segment, :origin => @position_a, :target => @position_b)
      @path_ac = Fabricate(:segment, :origin => @position_a, :target => @position_c)
      @path_ad = Fabricate(:segment, :origin => @position_a, :target => @position_d)
      @path_bc = Fabricate(:segment, :origin => @position_b, :target => @position_c)
      @path_be = Fabricate(:segment, :origin => @position_b, :target => @position_e)
      @path_cd = Fabricate(:segment, :origin => @position_c, :target => @position_d)
      @path_ce = Fabricate(:segment, :origin => @position_c, :target => @position_e)
      @path_de = Fabricate(:segment, :origin => @position_d, :target => @position_e)
    end
    
    it 'should be able to get a valid route between 2 points' do
      result = PathFinder.find(@position_a, @position_e)
      result.first[:position].should == @position_a
      result.last[:position].should == @position_e
      
      result[1][:path].positions.should include(@position_a)
      result.last[:path].positions.should include(@position_e)
    end
    
  end
end