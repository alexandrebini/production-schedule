require "spec_helper"

describe GARuby::Gene do

  it 'have product' do
    lambda{ GARuby::Gene.new(:product => nil, :roadmap => Roadmap.make) }.should raise_error
  end

  it 'have roadmap' do
    lambda{ GARuby::Gene.new(:product => Product.make, :roadmap => nil) }.should raise_error
  end

  it 'can be viewed as an array' do
    product = Product.make!
    roadmap = product.roadmaps.first

    gene = GARuby::Gene.new(:product => product, :roadmap => roadmap)
    gene.to_a.should == [product.id, roadmap.id]
  end

  it 'is cloneable' do
    first_gene = GARuby::Gene.new(:product => Product.make, :roadmap => Roadmap.make)
    second_gene = first_gene.clone
    first_gene.should_not == second_gene
    first_gene.object_id.should_not == second_gene.object_id
  end

  context 'swap' do
    before(:each) do
      @product = GARuby::Models::Product.make!
      @gene = @product.to_gene
    end

    it 'should be able to swap the roadmap' do
      lambda { @gene.swap_roadmap! }.should_not raise_error
    end

    it 'should be able to specify the new roadmap' do
      @gene.swap_roadmap!(@product.roadmaps.last)
      @gene.roadmap.should == @product.roadmaps.last
    end

    it 'should not keep the same roadmap' do
      before_swap = @gene.roadmap
      @gene.swap_roadmap!
      @gene.roadmap.should_not == before_swap
    end

    it 'keep the same roadmap if product has only one roadmap' do
      @product = GARuby::Models::Product.make!(:roadmaps => [Roadmap.make])
      @gene = @product.to_gene

      before_swap = @gene.roadmap
      @gene.swap_roadmap!
      @gene.roadmap.should == before_swap
    end
  end
end

