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

    chromosome1 = Chromosome.random :products => Product.find_all_by_id([1, 2])
    chromosome2 = Chromosome.random :products => Product.find_all_by_id([2, 3])

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

    first_chromosome.should_not == second_chromosome
    first_chromosome.object_id.should_not == second_chromosome.object_id

    for first_chromosome_gene in first_chromosome.genes
      for second_chromosome_gene in second_chromosome.genes
        first_chromosome_gene.should_not == second_chromosome_gene
        first_chromosome_gene.object_id.should_not == second_chromosome_gene.object_id
      end
    end
  end
end