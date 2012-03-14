require 'spec_helper'

describe Schema do
  it 'have a valid generator' do
    Fabricate(:schema).should be_valid
  end
  
  it 'should have a name' do
    Fabricate.build(:schema, :name => nil).should_not be_valid
  end
  
  it 'should be able to get a position of a machine' do
    schema = Fabricate(:schema, :positions => [])
    machine = Fabricate(:machine)
    position = Fabricate(:position, :schema => schema, :machine => machine)
    10.times{ Fabricate(:position, :schema => schema) }
        
    schema.reload.position_of_machine(machine).should == position
  end
end