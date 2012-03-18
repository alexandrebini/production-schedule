require 'spec_helper'

describe Chromosome do

  it 'have genes' do
    lambda{ Chromosome.new(:genes => nil) }.should raise_error
  end

  it 'should be able to generate a random' do
    2.times{ Fabricate(:product) }
    lambda{ Chromosome.random }.should_not raise_error
  end

  it 'have a gene for each product' do
    products_ids = Array.new(3){ Fabricate(:product) }.map(&:id)

    chromosome = Chromosome.random
    chromosome.genes.each do |gene|
      products_ids.should include(gene.product.id)
    end
  end

  it 'should be able to get fitness' do
    2.times{ Fabricate(:product) }
    chromosome = Chromosome.random
    lambda{ chromosome.fitness }.should_not raise_error
  end

  it 'is mutable' do
    2.times{ Fabricate(:product) }
    5.times{ Fabricate(:roadmap, :product => Product.random.first) }

    chromosome = Chromosome.random
    chromosome.mutate(100)
    for gene in chromosome.genes
      gene.roadmap.product_id.should == gene.product.id
    end
  end

  it 'is crossable' do
    3.times{ Fabricate(:product) }

    chromosome1 = Chromosome.new :products => Product.find_all_by_id([1, 2])
    chromosome2 = Chromosome.new :products => Product.find_all_by_id([2, 3])

    chromosome1_genes = chromosome1.genes.clone
    chromosome2_genes = chromosome2.genes.clone

    chromosome1.crossover(chromosome2, 100, 0)

    chromosome1.genes[0].roadmap.should == chromosome1_genes[0].roadmap
    chromosome1.genes[1].roadmap.should == chromosome2_genes[0].roadmap
    chromosome2.genes[0].roadmap.should == chromosome2_genes[0].roadmap
    chromosome2.genes[1].roadmap.should == chromosome2_genes[1].roadmap

    chromosome1.genes[0].roadmap.should_not == chromosome2_genes[0].roadmap
    chromosome1.genes[1].roadmap.should_not == chromosome1_genes[0].roadmap
    chromosome2.genes[0].roadmap.should_not == chromosome1_genes[0].roadmap
    chromosome2.genes[1].roadmap.should_not == chromosome1_genes[0].roadmap
  end

  it 'should be able to find gene by product' do
    2.times{ Fabricate(:product) }
    chromosome = Chromosome.random
    gene = chromosome.genes.last
    chromosome.find_by_product_id(gene.product.id).should == gene
  end

  it 'is cloneable' do
    2.times{ Fabricate(:product) }
    first_chromosome = Chromosome.random
    second_chromosome = first_chromosome.clone

    first_chromosome.should == second_chromosome
    first_chromosome.object_id.should_not == second_chromosome.object_id

    first_chromosome.genes.each_with_index do |gene, i|
      gene.should == second_chromosome.genes[i]
      gene.object_id.should_not == second_chromosome.genes[i].object_id
    end
  end
  
  it 'should be able to be compared with another chromosome' do
    p1, p2 = 2.times.map{ Fabricate(:product) }
    chromosome1 = Chromosome.new( :genes => [
      Gene.new(:product => p1, :roadmap => p1.roadmaps.first),
      Gene.new(:product => p2, :roadmap => p2.roadmaps.first)
    ])
    
    chromosome2 = Chromosome.new( :genes => [
      Gene.new(:product => p1, :roadmap => p1.roadmaps.first),
      Gene.new(:product => p2, :roadmap => p2.roadmaps.first)
    ])
    
    chromosome1.should == chromosome2
    chromosome1.object_id.should_not == chromosome2.object_id
  end
end