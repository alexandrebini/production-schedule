require "spec_helper"

describe GARuby::Chromosome do
  it 'have genes' do
    lambda{ GARuby::Chromosome.new(:genes => nil) }.should raise_error
  end

  it 'should be able to generate a random' do
    2.times{ Product.make! }
    lambda{ GARuby::Chromosome.random }.should_not raise_error
  end

  it 'have a gene for each product' do
    products_ids = Array.new(3){ Product.make! }.map(&:id)

    chromosome = GARuby::Chromosome.random
    chromosome.genes.each do |gene|
      products_ids.should include(gene.product.id)
    end
  end

  it 'can be viewed as an array' do
    2.times{ Product.make! }
    chromosome = GARuby::Chromosome.random
    lambda{ chromosome.to_a }.should_not raise_error
  end

  it 'is mutable'
  it 'is crossable'
end

