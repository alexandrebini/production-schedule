require "spec_helper"

describe Schema do
  it 'have a valid generator' do
    Fabricate(:schema).should be_valid
  end
  
  it 'should have a name' do
    Fabricate(:schema, :name => nil).should_not be_valid
  end
end