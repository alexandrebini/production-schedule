require "spec_helper"

describe GARuby::Models::Product do
  it 'have a valid generator' do
    GARuby::Models::Product.make!.should be_valid
  end

  it 'extends product model' do
    GARuby::Models::Product.ancestors.include?(Product).should be_true
  end

  it 'convert to random gene' do
    product = GARuby::Models::Product.make
    lambda { product.to_gene }.should_not raise_error
  end
end

