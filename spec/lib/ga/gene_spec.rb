require 'spec_helper'

describe Gene do

  it 'have a valid generator' do
    lambda{ Fabricate(:gene) }.should_not raise_error
  end
  
  it 'have product' do
    lambda{ Gene.new(:product => nil, :roadmap => Fabricate(:roadmap)) }.should raise_error
  end

  it 'have roadmap' do
    lambda{ Gene.new(:product => Fabricate(:product), :roadmap => nil) }.should raise_error
  end

  it 'transport is not required' do
    gene = Gene.new(:product => Fabricate(:product), :roadmap => Fabricate(:roadmap), :schema => nil)
    gene.transport.should be_nil
  end

  it 'is cloneable' do
    first_gene = Gene.new(:product => Fabricate(:product), :roadmap => Fabricate(:roadmap))
    second_gene = first_gene.clone
    first_gene.should_not == second_gene
    first_gene.object_id.should_not == second_gene.object_id
  end

  context 'swap' do
    before(:each) do
      @product = Fabricate(:product)
      @gene = Gene.new(:product => @product, :roadmap => @product.roadmaps.first)
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
      @product = Fabricate(:product, :roadmaps => [Fabricate.build(:roadmap)])
      @gene = Gene.new(:product => @product, :roadmap => @product.roadmaps.first)

      before_swap = @gene.roadmap
      @gene.swap_roadmap!
      @gene.roadmap.should == before_swap
    end
  end

end