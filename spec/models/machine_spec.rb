require 'spec_helper'

describe Machine do
  it 'have a valid generator' do
    Fabricate(:machine).should be_valid
  end

  it 'have a name' do
    Fabricate.build(:machine, :name => nil).should_not be_valid
  end

  it 'may have description' do
    Fabricate.build(:machine, :description => nil).should be_valid
    Fabricate.build(:machine, :description => Faker::Lorem.paragraph).should be_valid
  end
end