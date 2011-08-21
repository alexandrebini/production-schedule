module GARuby
  class Chromosome
    attr_reader :genes

    def initialize(args={})
      raise ArgumentError.new("genes are nil") if args[:genes].nil?
      options = { }
      options.merge!(args).each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def self.random(products = nil)
      products ||= Models::Product.all
      Chromosome.new :genes => products.shuffle.map(&:to_gene)
    end

    def to_a
      @genes.map(&:to_a).flatten
    end

  end
end

