require "spec_helper"

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
      @pathAB = Fabricate(:path, :origin => @positionA, :target => @positionB)
      @pathAC = Fabricate(:path, :origin => @positionA, :target => @positionC)
      @pathCD = Fabricate(:path, :origin => @positionD, :target => @positionB)
      @pathDB = Fabricate(:path, :origin => @positionB, :target => @positionD)
    end
    
    it 'should be able to get a valid route between 2 points' do
      result = PathFinder.find(@positionA, @positionD)
      result.path.first[:position].should == @positionA
      result.path.last[:position].should == @positionD
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
      @pathAB = Fabricate(:path, :origin => @positionA, :target => @positionB)
      @pathAC = Fabricate(:path, :origin => @positionA, :target => @positionC)
      @pathAD = Fabricate(:path, :origin => @positionA, :target => @positionD)
      @pathBC = Fabricate(:path, :origin => @positionB, :target => @positionC)
      @pathBE = Fabricate(:path, :origin => @positionB, :target => @positionE)
      @pathCD = Fabricate(:path, :origin => @positionC, :target => @positionD)
      @pathCE = Fabricate(:path, :origin => @positionC, :target => @positionE)
      @pathDE = Fabricate(:path, :origin => @positionD, :target => @positionE)
    end
    
    it 'should be able to get a valid route between 2 points' do
      result = PathFinder.find(@positionA, @positionE)
      result.path.first[:position].should == @positionA
      result.path.last[:position].should == @positionE
      
      result.path[1][:path].positions.should include(@positionA)
      result.path.last[:path].positions.should include(@positionE)
    end
    
  end
end