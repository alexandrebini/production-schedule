require 'spec_helper'

describe Population do
  it 'acts as array' do
    Population.ancestors.should include(Array)
  end
  
  it 'should be able to be compared with other population' do
    p1, p2 = 2.times.map{ Fabricate(:product) }
    chromosome1 = Chromosome.new( :genes => [
      Gene.new(:product => p1, :roadmap => p1.roadmaps.first),
      Gene.new(:product => p2, :roadmap => p2.roadmaps.first)
    ])

    chromosome2 = Chromosome.new( :genes => [
      Gene.new(:product => p1, :roadmap => p1.roadmaps.first),
      Gene.new(:product => p2, :roadmap => p2.roadmaps.first)
    ])
    
    chromosome3 = Chromosome.new( :genes => [
      Gene.new(:product => p1, :roadmap => p1.roadmaps.last),
      Gene.new(:product => p2, :roadmap => p2.roadmaps.last)
    ])
    
    population = Population.new(:chromosomes => [chromosome1, chromosome2])
    population.should == Population.new(:chromosomes => [chromosome1, chromosome2])
    population.should_not == Population.new(:chromosomes => [chromosome1, chromosome3])
  end
  
  context 'operations' do
    before(:each) do
      3.times{ Fabricate(:product) }

      @chromosome1 = Chromosome.random(:products => Product.find_all_by_id([1, 2]))
      @chromosome2 = Chromosome.random(:products => Product.find_all_by_id([2, 3]))

      @population = Population.new(:chromosomes => [@chromosome1, @chromosome2])
    end

    it 'should be able to select chromosome by tournament' do
      lambda{ @population.selection }.should_not raise_error
      @population.selection.is_a?(Array).should be_true
      @population.selection.each{ |r| r.is_a?(Chromosome).should be_true }
    end

    it 'should be able to get the best chromosome based on fitness' do
      best_fitness = @population.map{ |r| r.fitness }.min
      @population.best.fitness.should == best_fitness
    end

    it 'should be able to be cloned' do
      cloned = @population.clone
      cloned.should == @population
      cloned.object_id.should_not == @population.object_id
    end

    it 'selected chromosome should be cloned' do
      selected_chromosome = @population.selection.first
      chromosome = @population.find{ |r| r == selected_chromosome }

      selected_chromosome.object_id.should_not == chromosome.object_id
      selected_chromosome.genes.object_id.should_not == chromosome.genes.object_id
      
      selected_chromosome.genes.each_with_index do |gene, i|
        gene.should == chromosome.genes[i]
        gene.object_id.should_not == chromosome.genes[i].object_id
      end
    end
  end
  
  context 'creating distinct chromosomes' do
    
    it 'get the right number of combinations' do
      products = 1.times.map{ Fabricate(:product, :roadmaps => 2.times.map{ Fabricate :roadmap }) }
      Population.max_combinations(products).should == 2
      
      products = 1.times.map{ Fabricate(:product, :roadmaps => 3.times.map{ Fabricate :roadmap }) }
      Population.max_combinations(products).should == 3
      
      
      products = 2.times.map{ Fabricate(:product, :roadmaps => 1.times.map{ Fabricate :roadmap }) }
      Population.max_combinations(products).should == 2
      
      products = 2.times.map{ Fabricate(:product, :roadmaps => 2.times.map{ Fabricate :roadmap }) }
      Population.max_combinations(products).should == 8
      
      products = 2.times.map{ Fabricate(:product, :roadmaps => 3.times.map{ Fabricate :roadmap }) }
      Population.max_combinations(products).should == 18
      
      
      products = 3.times.map{ Fabricate(:product, :roadmaps => 1.times.map{ Fabricate :roadmap }) }
      Population.max_combinations(products).should == 6

      products = 3.times.map{ Fabricate(:product, :roadmaps => 2.times.map{ Fabricate :roadmap }) }
      Population.max_combinations(products).should == 48
            
      products = 3.times.map{ Fabricate(:product, :roadmaps => 3.times.map{ Fabricate :roadmap }) }
      Population.max_combinations(products).should == 162
      
      products = 4.times.map{ Fabricate(:product, :roadmaps => 1.times.map{ Fabricate :roadmap }) }
      Population.max_combinations(products).should == 24
      
      products = 4.times.map{ Fabricate(:product, :roadmaps => 2.times.map{ Fabricate :roadmap }) }
      Population.max_combinations(products).should == 384
    end
    
    it 'for 2 products' do
      products = 2.times.map{ Fabricate(:product, :roadmaps => 4.times.map{ Fabricate :roadmap }) }
      population = Population.new(:products => products)
      
      population.each_with_index do |chromosome, i|  
        break unless i < population.size-1
        chromosome.should_not == population[i+1]
      end
    end
    
  end
  
end