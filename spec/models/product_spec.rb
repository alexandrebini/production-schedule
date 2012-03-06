require "spec_helper"

describe Product do
  it 'have a valid generator' do
    Fabricate(:product).should be_valid
  end

  it 'have a name' do
    Fabricate.build(:product, :name => nil).should_not be_valid
  end

  it 'may have description' do
    Fabricate.build(:product, :description => nil).should be_valid
    Fabricate.build(:product, :description => Faker::Lorem.paragraph).should be_valid
  end

end