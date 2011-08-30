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

  it 'should be able to get fitness' do
    2.times{ Product.make! }
    chromosome = GARuby::Chromosome.random
    lambda{ chromosome.fitness }.should_not raise_error
  end

  it 'is mutable' do
    2.times{ Product.make! }
    5.times{ Roadmap.make!(:product => Product.random.first) }

    chromosome = GARuby::Chromosome.random
    chromosome.mutate(100)
    for gene in chromosome.genes
      gene.roadmap.product_id.should == gene.product.id
    end
  end

  it 'is crossable' do
    3.times{ Product.make! }

    chromosome1 = GARuby::Chromosome.new(:genes => GARuby::Models::Product.find_all_by_id([1, 2]).map(&:to_gene) )
    chromosome2 = GARuby::Chromosome.new(:genes => GARuby::Models::Product.find_all_by_id([2, 3]).map(&:to_gene) )

    chromosome1.crossover(chromosome2, 100, 0)

    chromosome1.genes[0].roadmap.should_not == chromosome2.genes[0].roadmap
    chromosome1.genes[1].roadmap.should == chromosome2.genes[0].roadmap
    chromosome1.genes[1].roadmap.should_not == chromosome2.genes[1].roadmap
  end

  it 'should be able to find gene by product' do
    2.times{ Product.make! }
    chromosome = GARuby::Chromosome.random
    gene = chromosome.genes.last
    chromosome.find_by_product_id(gene.product.id).should == gene
  end

  it 'is cloneable' do
    2.times{ Product.make! }
    first_chromosome = GARuby::Chromosome.random
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

