require "spec_helper"

describe Product do
  it 'have a valid generator' do
    Product.make!.should be_valid
  end

  it 'have a name' do
    Product.make(:name => nil).should_not be_valid
  end

  it 'may have description' do
    Product.make(:description => nil).should be_valid
    Product.make(:description => Faker::Lorem.paragraph).should be_valid
  end
end

