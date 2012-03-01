require "spec_helper"

describe Position do
  it 'have a valid generator' do
    Fabricate(:position).should be_valid
  end
  
  it 'should have a schema' do
    Fabricate.build(:position, :schema => nil).should_not be_valid
  end
  
  it 'should have a machine' do
    Fabricate.build(:position, :machine => nil).should_not be_valid
  end
end