require "spec_helper"

describe Machine do
  it 'have a valid generator' do
    Machine.make!.should be_valid
  end

  it 'have a name' do
    Machine.make(:name => nil).should_not be_valid
  end

  it 'may have description' do
    Machine.make(:description => nil).should be_valid
    Machine.make(:description => Faker::Lorem.paragraph).should be_valid
  end
end

