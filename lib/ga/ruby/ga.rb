class GA
  require File.expand_path('../chromosome', __FILE__)
  require File.expand_path('../gene', __FILE__)

  attr_reader :population, :length, :generations
  attr_reader :mutation_rate, :crossover_rate, :max_generations

  def initialize(args={})
    options = { :length => 40, :mutation_rate => 5, :crossover_rate => 75, :max_generations => 10000 }
    options.merge!(args).each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    @generations = 0
    @population = Array.new(options[:length]){ Chromosome.random(args[:products]) }
  end

  def selection(current_population=@population)
    chromosome = best_chromosome(@population.shuffle[0..4])
    current_population.delete chromosome
    chromosome#.clone
  end

  def run
    while @generations < max_generations
      # store the current fitness
      current_population = @population.clone
      current_fitness = population_fitness(current_population)

      # stores the best chromosome to send it to the next generation
      next_population = []
      next_population << current_population.delete(best_chromosome)

      # puts "#{@generations}/#{@max_generations} (before): #{population_fitness}"
      while next_population.size < @length
        chromosome1 = selection(current_population)
        chromosome2 = selection(current_population)

        f1 = chromosome1.fitness
        f2 = chromosome2.fitness

        # crossover
        chromosome1.crossover chromosome2, @crossover_rate

        #puts "chromosome1 after crossover: #{chromosome1.genes.map(&:to_a)} "

        # mutate
        chromosome1.mutate @mutation_rate
        chromosome2.mutate @mutation_rate

        puts "fitness ch1: #{f1} - #{chromosome1.fitness}"
        puts "fitness ch2: #{f2} - #{chromosome2.fitness}"
        puts

        # add to next population
        next_population.push chromosome1 if next_population.size < @length
        next_population.push chromosome2 if next_population.size < @length
      end

      adjust_rates! current_fitness, population_fitness(next_population)

      # replace the population
      @population = next_population

      puts "#{@generations}/#{@max_generations} (after): #{population_fitness}"

      # increase population counter
      @generations += 1
    end
  end

  def adjust_rates!(current_fitness, next_fitness)
    # percentage difference. *-100 because the lower the fitness, the better
    fitness_difference = (next_fitness.to_f - current_fitness.to_f) / current_fitness.to_f * -100
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
    population.min_by{ |chromosome| chromosome.fitness }
  end

  def population_fitness(population=@population)
    population.inject(0){ |sum,x| sum += x.fitness }
  end

end

