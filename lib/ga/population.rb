class Population < Array

  def initialize(args={})
    if args[:chromosomes]
      super args[:chromosomes]
    elsif args[:products]
      super Population.distinct_chromosomes(args)
    end
  end

  def selection(quantity=2)
    self.shuffle[0..4].sort_by do |chromosome| 
      chromosome.fitness
    end[0..quantity-1].map{ |chromosome| chromosome.clone }
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
  
  def == population
    return false if self.size != population.size
    self.each_with_index do |chromosome, i|
      return false unless chromosome == population[i]
    end
    return true
  end
  
  class << self
    def max_combinations(products)
      # Conditional Arrangement
      # Ac = A(m1, p1) × A(m − m1, p − p1)
      # max_combinations = products! * Ac(p1) * Ac(p2) * Ac(pN)
      combinations = products.size.factorial
      products.each do |product|
        combinations *= product.roadmaps.size.factorial / (product.roadmaps.size - 1).factorial
      end      
      combinations
    end
        
    def distinct_chromosomes(args={})
      length = max_combinations(args[:products])
      length = args[:length] if args[:length] && args[:length] < length
      
      chromosomes = []
      while(chromosomes.size < length)
        chromosome = Chromosome.random(:products => args[:products], :schema => args[:schema], :cache => args[:cache])
        chromosomes << chromosome unless chromosomes.find{ |r| r == chromosome }
      end
      
      chromosomes
    end
  end
  
end