class Population < Array

  def initialize(args={})
    if args[:chromosomes]
      super args[:chromosomes]
    elsif args[:length] && args[:products]
      super(args[:length]){ Chromosome.random(:products => args[:products], :cache => args[:cache]) }
    end
  end

  def selection
    best(self.shuffle[0..4]).clone
  end

  def best(chromosomes=self)
    chromosomes.min_by{ |chromosome| chromosome.fitness }
  end

  def fitness
    self.inject(0){ |sum,x| sum += x.fitness }
  end

  def clone
    Population.new :chromosomes => self.map(&:clone)
  end
end

