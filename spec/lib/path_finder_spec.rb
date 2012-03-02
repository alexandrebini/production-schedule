require "spec_helper"

describe PathFinder do
  context '4 positions schema' do
    before(:each) do
      # A -- B
      # |    |
      # C -- D
      schema = Fabricate(:schema)
      positionA = Fabricate(:position, :schema => schema)
      positionB = Fabricate(:position, :schema => schema)
      positionC = Fabricate(:position, :schema => schema)
      positionD = Fabricate(:position, :schema => schema)
      @pathAB = Fabricate(:path, :origin => positionA, :target => positionB)
      @pathAC = Fabricate(:path, :origin => positionA, :target => positionC)
      @pathCD = Fabricate(:path, :origin => positionD, :target => positionB)
      @pathDB = Fabricate(:path, :origin => positionB, :target => positionD)
    end
    
    it 'should be able to get a valid route between 2 points' do
      PathFinder.find()
    end
  end
end