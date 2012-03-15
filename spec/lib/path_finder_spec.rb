require 'spec_helper'

describe PathFinder do
  context '4 positions schema' do
    before(:each) do
      # A -- B
      # |    |
      # C -- D
      schema = Fabricate(:schema)
      @positionA = Fabricate(:position, :schema => schema)
      @positionB = Fabricate(:position, :schema => schema)
      @positionC = Fabricate(:position, :schema => schema)
      @positionD = Fabricate(:position, :schema => schema)
      @pathAB = Fabricate(:segment, :origin => @positionA, :target => @positionB)
      @pathAC = Fabricate(:segment, :origin => @positionA, :target => @positionC)
      @pathCD = Fabricate(:segment, :origin => @positionD, :target => @positionB)
      @pathDB = Fabricate(:segment, :origin => @positionB, :target => @positionD)
    end
    
    it 'should be able to get a valid route between 2 points' do
      result = PathFinder.find(@positionA, @positionD)
      result.first[:position].should == @positionA
      result.last[:position].should == @positionD
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
      @positionA = Fabricate(:position, :schema => schema)
      @positionB = Fabricate(:position, :schema => schema)
      @positionC = Fabricate(:position, :schema => schema)
      @positionD = Fabricate(:position, :schema => schema)
      @positionE = Fabricate(:position, :schema => schema)
      @pathAB = Fabricate(:segment, :origin => @positionA, :target => @positionB)
      @pathAC = Fabricate(:segment, :origin => @positionA, :target => @positionC)
      @pathAD = Fabricate(:segment, :origin => @positionA, :target => @positionD)
      @pathBC = Fabricate(:segment, :origin => @positionB, :target => @positionC)
      @pathBE = Fabricate(:segment, :origin => @positionB, :target => @positionE)
      @pathCD = Fabricate(:segment, :origin => @positionC, :target => @positionD)
      @pathCE = Fabricate(:segment, :origin => @positionC, :target => @positionE)
      @pathDE = Fabricate(:segment, :origin => @positionD, :target => @positionE)
    end
    
    it 'should be able to get a valid route between 2 points' do
      result = PathFinder.find(@positionA, @positionE)
      result.first[:position].should == @positionA
      result.last[:position].should == @positionE
      
      result[1][:path].positions.should include(@positionA)
      result.last[:path].positions.should include(@positionE)
    end
    
  end
end