require 'thread'

class GA
  require File.expand_path('../cache', __FILE__)
  require File.expand_path('../population', __FILE__)
  require File.expand_path('../chromosome', __FILE__)
  require File.expand_path('../gene', __FILE__)

  attr_reader :population, :length, :generations
  attr_reader :mutation_rate, :crossover_rate, :max_generations
  attr_reader :max_threads, :cache, :products

  def initialize(args={})
    options = { :length => 40, :mutation_rate => 5, :crossover_rate => 75, :max_generations => 10000, :max_threads => 5 }
    options.merge!(args).each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    @cache = Cache.new
    @generations = 0
    @population = Population.new(:length => @length, :products => args[:products], :schema => args[:schema], :cache => @cache)
    @length = @population.size
  end

  def run
    while @generations < max_generations
      # stores the best chromosome to send it to the next generation
      next_population = Population.new
      next_population << @population.best

      @max_threads.times.map do
        Thread.new do

          while next_population.size < @length
            # selection
            chromosome1, chromosome2 = @population.selection(2)

            # crossover
            chromosome1.crossover chromosome2, @crossover_rate

            # mutate
            chromosome1.mutate @mutation_rate
            chromosome2.mutate @mutation_rate

            # add to next population
            next_population.push(chromosome1) if next_population.size < @length && !next_population.include?(chromosome1)
            next_population.push(chromosome2) if next_population.size < @length && !next_population.include?(chromosome2)
          end
        end
      end.each(&:join)
      
      adjust_rates! @population.fitness, next_population.fitness

      # replace the population
      @population = next_population

      puts "#{@generations + 1}/#{@max_generations} \t total: #{population.fitness} \t best: #{population.best.fitness} \t\t mutation rate: #{@mutation_rate}% \t crossover rate: #{@crossover_rate}%"
      
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

end