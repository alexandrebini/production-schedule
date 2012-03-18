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
      product_combinations = (1..products.count).inject(:*)
      additional_roadmaps = products.sum do |product| 
        product.roadmaps.count > 1 ? product.roadmaps.count-1 : 0
      end
      
      puts "products: #{products.count}  roadmaps: #{products.sum{|r| r.roadmaps.count} }"
      puts "product_combinations: #{product_combinations}"
      puts "additional_roadmaps: #{additional_roadmaps}"
      puts "max_combinations: #{product_combinations + additional_roadmaps}"
      puts "#{ products.sum { |r| (1..r.roadmaps.count).inject(:*) }}" 
      possible_genes = products.sum{ |r| r.roadmaps.count }
      puts "possible_genes: #{possible_genes}  #{ (1..possible_genes).inject(:*) }   possible_genes*products: #{possible_genes*products.size}"
      puts
            
      product_combinations + additional_roadmaps
    end
    
    def distinct_chromosomes(args={})
      roadmaps_count = args[:products].sum{ |r| r.roadmaps.count }
      # this is a factorial of products count + roadmaps count
      max_combinations = 100

      #p "====="
      #p "roadmaps_count: #{roadmaps_count}"
      #p "args[:products].count: #{args[:products].count}"
      #p "max_combinations: #{max_combinations}"

      # pra cada produto
      # o numero de genes possíveis é = ao numero de roadmaps
      
      # cada cromossomo 
      # => deve ter todos os produtos (apenas um de cada)
      # => os produtos são colocados em ordem aleatória
      
      # => se eu tiver apenas 1 opcao de gene por produto
      # =>  então o número de chromosomos possível = fatorial(numero de produtos)
      
      # => se eu tiver 2 opcões de gene por produto
      # =>   então 
      
      
      
      #possible_genes = args[:product].sum{ |r| r.roadmaps.count }
      

      chromosomes = []
      if args[:length].blank?
        length = max_combinations
      else
        length = [max_combinations, args[:length]].min
      end

      while chromosomes.size < length
        p "chromosomes.size: #{chromosomes.size}   length: #{length}  max_combinations: #{max_combinations}"
        chromosome = Chromosome.random(:products => args[:products], :schema => args[:schema], :cache => args[:cache])
        chromosomes << chromosome unless chromosomes.find{ |r| r == chromosome }
      end

      chromosomes
    end
  end
  
end