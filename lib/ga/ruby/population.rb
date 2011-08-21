module GARuby
  class Population
    attr_reader :chromosomes, :length, :generations, :max_generations

    def initialize(args={})
      options = { :length => 40, :max_generations => 1000 }
      options.merge!(args).each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
      @generations = 0
      @chromosomes = Array.new(@length){ Chromosome.random }
    end


  end
end

