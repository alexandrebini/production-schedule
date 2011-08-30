class GARuby
  class Chromosome
    attr_reader :genes

    def initialize(args={})
      raise ArgumentError.new("genes are nil") if args[:genes].nil?
      @genes = args[:genes]
    end

    def self.random(products = nil)
      products ||= Models::Product.all
      Chromosome.new :genes => products.shuffle.map(&:to_gene)
    end

    def to_a
      @genes.map(&:to_a).flatten
    end

    def fitness
      rand 9999
    end

    def mutate(rate)
      return if rand(100) > rate
      @genes[rand @genes.size].swap_roadmap!
    end

    def crossover(chromosome, rate, position=nil)
      return if rand(100) > rate
      position = rand(@genes.size - 1) if position.nil?
      position.upto(@genes.size - 1) do |index|
        first_gene = @genes[index]
        second_gene = chromosome.find_by_product_id(first_gene.product.id)
        next if second_gene.nil?

        @genes[index].swap_roadmap! second_gene.roadmap
        second_gene.swap_roadmap! first_gene.roadmap
      end
    end

    def find_by_product_id(product_id)
      @genes.find{ |gene| gene.product.id == product_id }
    end

    def clone
      GARuby::Chromosome.new :genes => @genes.map(&:clone)
    end

  end
end

