class GARuby
  require File.expand_path('../chromosome', __FILE__)
  require File.expand_path('../gene', __FILE__)
  #require File.expand_path('../models/product', __FILE__)
  module Models
    autoload :Product, File.expand_path('../models/product', __FILE__)
  end

  attr_reader :population, :length, :generations
  attr_reader :mutation_rate, :crossover_rate, :max_generations

  def initialize(args={})
    options = { :length => 40, :mutation_rate => 0.1, :crossover_rate => 75, :max_generations => 10000 }
    options.merge!(args).each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    @generations = 0
    @population = Array.new(options[:length]){ Chromosome.random }
  end

  def selection
    best_chromosome(@population.shuffle[0..4]).clone
  end

  def run
    while @generations < max_generations
      # store the current fitness
      current_fitness = population_fitness(@population)

      next_population = []

      # stores the best chromosome to send it to the next generation
      next_population << best_chromosome

      while next_population.size < @length
        chromosome1 = selection
        chromosome2 = selection

        # crossover
        chromosome1.crossover chromosome2, @crossover_rate

        # mutate
        chromosome1.mutate @mutation_rate
        chromosome2.mutate @mutation_rate

        # add to next population
        next_population.push chromosome1 if next_population.size < @length
        next_population.push chromosome2 if next_population.size < @length
      end

      adjust_rates! current_fitness, population_fitness(next_population)

      # replace the population
      @population = next_population

      # increase population counter
      @generations += 1
    end
  end

  def adjust_rates!(current_fitness, next_fitness)
    fitness_difference = (next_fitness.to_f - current_fitness.to_f) / current_fitness.to_f * 100
    # if fitness increase 10% or more
    if fitness_difference >= 10
      # increase crossover rate by 5% respecting the limit of 100%
      @crossover_rate = [@crossover_rate+5, 100].min
      # increase mutation rate by 0.5% respecting the limit of 10%
      @mutation_rate  = [@mutation_rate+0.5, 10].min
    elsif fitness_difference <= -10
      # decreases crossover rate by 5% respecting the limit of 50%
      @crossover_rate = [@crossover_rate-5, 50].max
      # decreases mutation rate by 0.5% respecting the limit of 0%
      @mutation_rate  = [@mutation_rate-0.5, 0].max
    end
  end

  def best_chromosome(population=@population)
    population.max_by{ |chromosome| chromosome.fitness }
  end

  def population_fitness(population=@population)
    population.inject(0){ |sum,x| sum += x.fitness }
  end

end

