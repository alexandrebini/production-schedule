require "spec_helper"

describe Chromosome do
  context 'intercalary in the right order' do
    before(:each) do
      @m1 = Machine.make!
      @m2 = Machine.make!
      @m3 = Machine.make!

      @p1 = Product.make :operation_times => [], :roadmaps => [Roadmap.make(:machines => [@m1, @m2, @m3])]
      @p2 = Product.make :operation_times => [], :roadmaps => [Roadmap.make(:machines => [@m2, @m1, @m3])]
    end

    it 'for linear times' do
      chromosome = Chromosome.new :genes =>[@p1, @p2].map(&:to_gene)

      OperationTime.make! :product => @p1, :machine => @m1, :time => 100
      OperationTime.make! :product => @p1, :machine => @m2, :time => 100
      OperationTime.make! :product => @p1, :machine => @m3, :time => 100

      OperationTime.make! :product => @p2, :machine => @m2, :time => 100
      OperationTime.make! :product => @p2, :machine => @m1, :time => 100
      OperationTime.make! :product => @p2, :machine => @m3, :time => 100

      chromosome.schedule[0].should == { :product_id => @p1.id, :machine_id => @m1.id, :start_at => 0,   :end_at => 100 }
      chromosome.schedule[1].should == { :product_id => @p2.id, :machine_id => @m2.id, :start_at => 0,   :end_at => 100 }
      chromosome.schedule[2].should == { :product_id => @p1.id, :machine_id => @m2.id, :start_at => 100, :end_at => 200 }
      chromosome.schedule[3].should == { :product_id => @p2.id, :machine_id => @m1.id, :start_at => 100, :end_at => 200 }
      chromosome.schedule[4].should == { :product_id => @p1.id, :machine_id => @m3.id, :start_at => 200, :end_at => 300 }
      chromosome.schedule[5].should == { :product_id => @p2.id, :machine_id => @m3.id, :start_at => 300, :end_at => 400 }
    end

    it 'for intermediate times' do
      chromosome = Chromosome.new :genes =>[@p2, @p1].map(&:to_gene)

      OperationTime.make! :product => @p1, :machine => @m1, :time => 150
      OperationTime.make! :product => @p1, :machine => @m2, :time => 150
      OperationTime.make! :product => @p1, :machine => @m3, :time => 100

      OperationTime.make! :product => @p2, :machine => @m1, :time => 100
      OperationTime.make! :product => @p2, :machine => @m2, :time => 50
      OperationTime.make! :product => @p2, :machine => @m3, :time => 100

      chromosome.schedule[0].should == { :product_id => @p2.id, :machine_id => @m2.id, :start_at => 0,   :end_at => 50 }
      chromosome.schedule[1].should == { :product_id => @p1.id, :machine_id => @m1.id, :start_at => 0,   :end_at => 150 }
      chromosome.schedule[2].should == { :product_id => @p2.id, :machine_id => @m1.id, :start_at => 150, :end_at => 250 }
      chromosome.schedule[3].should == { :product_id => @p1.id, :machine_id => @m2.id, :start_at => 150, :end_at => 300 }
      chromosome.schedule[4].should == { :product_id => @p2.id, :machine_id => @m3.id, :start_at => 250, :end_at => 350 }
      chromosome.schedule[5].should == { :product_id => @p1.id, :machine_id => @m3.id, :start_at => 350, :end_at => 450 }
    end
  end

  it 'have genes' do
    lambda{ Chromosome.new(:genes => nil) }.should raise_error
  end

  it 'should be able to generate a random' do
    2.times{ Product.make! }
    #lambda{ Chromosome.random }.should_not raise_error
    Chromosome.random
  end

  it 'have a gene for each product' do
    products_ids = Array.new(3){ Product.make! }.map(&:id)

    chromosome = Chromosome.random
    chromosome.genes.each do |gene|
      products_ids.should include(gene.product.id)
    end
  end

  it 'can be viewed as an array' do
    2.times{ Product.make! }
    chromosome = Chromosome.random
    lambda{ chromosome.to_a }.should_not raise_error
  end

  it 'should be able to get fitness' do
    2.times{ Product.make! }
    chromosome = Chromosome.random
    chromosome.fitness
    #lambda{ chromosome.fitness }.should_not raise_error
  end

  it 'is mutable' do
    2.times{ Product.make! }
    5.times{ Roadmap.make!(:product => Product.random.first) }

    chromosome = Chromosome.random
    chromosome.mutate(100)
    for gene in chromosome.genes
      gene.roadmap.product_id.should == gene.product.id
    end
  end

  it 'is crossable' do
    3.times{ Product.make! }

    chromosome1 = Chromosome.new(:genes => Product.find_all_by_id([1, 2]).map(&:to_gene) )
    chromosome2 = Chromosome.new(:genes => Product.find_all_by_id([2, 3]).map(&:to_gene) )

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
    2.times{ Product.make! }
    chromosome = Chromosome.random
    gene = chromosome.genes.last
    chromosome.find_by_product_id(gene.product.id).should == gene
  end

  it 'is cloneable' do
    2.times{ Product.make! }
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

