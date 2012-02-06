class Chromosome
  attr_reader :genes, :fitness
  attr_reader :cache, :schedule

  def initialize(args={})
    args.each { |k,v| instance_variable_set("@#{k}", v) unless v.nil? }
    raise ArgumentError.new("genes are nil") if @genes.nil?
    @cache ||= Cache.new
    @cache.add_products @genes.map(&:product)
    @schedule = []
  end

  def self.random(args={})
    products = args[:products] || Product.all
    Chromosome.new :genes => products.shuffle.map(&:to_gene), :cache => args[:cache]
  end

  def to_a
    @genes.map(&:to_a).flatten
  end

  def fitness
    return @fitness unless @fitness.nil? || @genes_changed
    schedule
    last_operation[:end_at] - first_operation[:start_at]
  end

  def mutate(rate)
    return if rand(100) > rate

    @genes[rand @genes.size].swap_roadmap!
    @genes_changed = true
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
    @genes_changed = true
  end

  def find_by_product_id(product_id)
    @genes.find{ |gene| gene.product.id == product_id }
  end

  def clone
    if @schedule
      Chromosome.new :genes => @genes.map(&:clone), :genes_changed => false, :schedule => @schedule.clone, :fitness => @fitness
    else
      Chromosome.new :genes => @genes.map(&:clone)
    end
  end

  def schedule
    return @schedule unless @schedule.blank? || @genes_changed

    max_machines = @genes.map{ |r| r.roadmap.machines.size }.max.to_i

    max_machines.times do |time|
      for gene in @genes
        machine = gene.roadmap.machines[time]
        next if machine.nil?
        start_at = 0

        last_operation_of_machine = operations_of_machine(machine.id).last
        start_at = last_operation_of_machine[:end_at] if last_operation_of_machine

        last_operation_of_product = operations_of_product(gene.product.id).last
        start_at = last_operation_of_product[:end_at] if last_operation_of_product && last_operation_of_product[:end_at] > start_at

        operation_time = @cache.operation_times.of_product_and_machine(gene.product.id, machine.id)

        @schedule << { :product_id => gene.product.id, :machine_id => machine.id, :start_at => start_at, :end_at => start_at + operation_time.time }
      end
    end
    @schedule
  end

  def operations_of_machine(machine_id)
    @schedule.find_all{ |r| r[:machine_id] == machine_id }
  end

  def operations_of_product(product_id)
    @schedule.find_all{ |r| r[:product_id] == product_id }
  end

  def first_operation
    @schedule.sort_by{ |r| r[:start_at] }.first
  end

  def last_operation
    @schedule.sort_by{ |r| r[:end_at] }.last
  end

end