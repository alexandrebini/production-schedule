require "spec_helper"

describe Population do
  before(:each) do
    3.times{ Fabricate(:product) }

    @chromosome1 = Chromosome.new(:genes => Product.find_all_by_id([1, 2]).map(&:to_gene) )
    @chromosome2 = Chromosome.new(:genes => Product.find_all_by_id([2, 3]).map(&:to_gene) )

    @population = Population.new(:chromosomes => [@chromosome1, @chromosome2])
  end

  it 'acts as array' do
    Population.ancestors.should include(Array)
  end

  it 'should be able to select chromosome by tournament' do
    lambda{ @population.selection }.should_not raise_error
    @population.selection.is_a?(Chromosome).should be_true
  end

  it 'should be able to get the best chromosome based on fitness' do
    best_fitness = @population.map{ |r| r.fitness }.min
    @population.best.fitness.should == best_fitness
  end

  it 'should be able to be cloned' do
    cloned = @population.clone
    cloned.should_not == @population
    cloned.object_id.should_not == @population.object_id
  end

  it 'selected chromosome should be cloned' do
    selected_chromosome = @population.selection
    for chromosome in @population
      selected_chromosome.should_not == chromosome
      selected_chromosome.object_id.should_not == chromosome.object_id
      selected_chromosome.genes.object_id.should_not == chromosome.genes.object_id
      for gene in chromosome.genes
        for selected_gene in selected_chromosome.genes
          selected_gene.should_not == gene.should_not
          selected_gene.object_id.should_not == gene.object_id.should_not
        end
      end

    end
  end

end

