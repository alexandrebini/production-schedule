class Population
  attr_reader :chromosomes
  
  def initialize(args={})
    @chromosomes = []
    if args[:chromosomes]
      @chromosomes = args[:chromosomes]
    elsif args[:length] && args[:products]
      @chromosomes = Array.new(args[:length]){ Chromosome.random(args[:products]) }
    end
  end
  
  def selection
    best @chromosomes.shuffle[0..4]
  end
  
  def best(chromosomes=@chromosomes)
    chromosomes.min_by{ |chromosome| chromosome.fitness }
  end

  def fitness
    @chromosomes.inject(0){ |sum,x| sum += x.fitness }
  end
  
  def clone
    Population.new :chromosomes => @chromosomes.map(&:clone)
  end
  
  def push(chromosome)
    @chromosomes.push chromosome
  end
  
  def <<(chromosome)
    @chromosomes << chromosome
  end
  
  def size
    @chromosomes.size
  end
end